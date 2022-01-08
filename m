From: Guilherme G. Piccoli <gpiccoli@igalia.com>
Date: Sat, 8 Jan 2022 12:36:32 -0300
Subject: [PATCH] notifier/panic: Introduce panic_notifier_filter
In-Reply-To: <CAHp75Vf8SisR16tK=hwiF9ET0PoQRcu1h5LCZHZAGX8M3KysRA@mail.gmail.com>
References: <20220107191233.172644-1-gpiccoli@igalia.com>
 <CAHp75Vf8SisR16tK=hwiF9ET0PoQRcu1h5LCZHZAGX8M3KysRA@mail.gmail.com>
Message-ID: <c2923957-9719-ef23-802a-24765ead7630@igalia.com>
List-Id: <kexec.lists.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: kexec@lists.infradead.org

On 07/01/2022 20:07, Andy Shevchenko wrote:
> [...] 
>     +? ? ? ?if (!buf)
>     +? ? ? ? ? ? ? ?return -EINVAL;
> 
> 
> I also implied that you don?t need this condition.
> 
>     +? ? ? ?while ((func = strsep(&buf, ","))) {
>     +? ? ? ? ? ? ? ?addr = kallsyms_lookup_name(func);
> 
> ?
> 
>     +
> 
> 
> Btw, this is redundant blank line.
> ?
> 
>     +? ? ? ? ? ? ? ?if (!addr) {

Thanks Andy, just submitted a V4 that incorporates your suggestions.
Cheers,


Guilherme

