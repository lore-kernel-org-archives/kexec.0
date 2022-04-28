From: Randy Dunlap <rdunlap@infradead.org>
Date: Wed, 27 Apr 2022 17:28:11 -0700
Subject: [PATCH 24/30] panic: Refactor the panic path
In-Reply-To: <20220427224924.592546-25-gpiccoli@igalia.com>
References: <20220427224924.592546-1-gpiccoli@igalia.com>
 <20220427224924.592546-25-gpiccoli@igalia.com>
Message-ID: <4fe85e9c-4e96-e9d5-9fd8-f062bafcda4f@infradead.org>
List-Id: <kexec.lists.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: kexec@lists.infradead.org



On 4/27/22 15:49, Guilherme G. Piccoli wrote:
> +	crash_kexec_post_notifiers
> +			This was DEPRECATED - users should always prefer the

			This is DEPRECATED - users should always prefer the

> +			parameter "panic_notifiers_level" - check its entry
> +			in this documentation for details on how it works.
> +			Setting this parameter is exactly the same as setting
> +			"panic_notifiers_level=4".

-- 
~Randy

