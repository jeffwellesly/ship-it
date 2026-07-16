type Props = { size?: number; className?: string }

export default function CoinIcon({ size = 13, className }: Props) {
  return (
    <svg
      xmlns="http://www.w3.org/2000/svg"
      width={size}
      height={size}
      viewBox="0 0 24 24"
      className={className}
      aria-hidden="true"
    >
      <circle cx="12" cy="12" r="9.5" fill="#FAC775" stroke="#C6862B" strokeWidth="1.5" />
      <circle cx="12" cy="12" r="6.5" fill="none" stroke="#C6862B" strokeWidth="1" opacity="0.6" />
      <path d="M12 8.2v7.6M10 10.1c0-.8.8-1.5 2-1.5s2 .6 2 1.3c0 1.7-4 1-4 2.7 0 .8.9 1.4 2.1 1.4s2-.6 2-1.4" stroke="#C6862B" strokeWidth="1.1" fill="none" strokeLinecap="round" opacity="0.75" />
    </svg>
  )
}
