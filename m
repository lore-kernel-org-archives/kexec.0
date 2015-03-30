Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Message-ID: <55196AEB.2040204@redhat.com>
Date: Mon, 30 Mar 2015 20:55:31 +0530
From: Pratyush Anand <panand@redhat.com>
MIME-Version: 1.0
Subject: Re: arm64 kexec hang
References: <1427477015.27739.30.camel@infradead.org>
 <5515C799.8010600@redhat.com> <551940F5.9050102@redhat.com>
 <55195FE3.5090409@redhat.com>
In-Reply-To: <55195FE3.5090409@redhat.com>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Geoff Levand <geoff@infradead.org>
Cc: "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Takahiro Akashi <takahiro.akashi@linaro.org>, kexec@lists.infradead.org, Vivek Goyal <vgoyal@redhat.com>, Kyle McMartin <kmcmarti@redhat.com>

Hi Geoff,


On Monday 30 March 2015 08:08 PM, Pratyush Anand wrote:
> diff --git a/kexec/arch/arm64/kexec-arm64.c
> b/kexec/arch/arm64/kexec-arm64.c
> index 8df66f5c8273..4365bb4087ad 100644
> --- a/kexec/arch/arm64/kexec-arm64.c
> +++ b/kexec/arch/arm64/kexec-arm64.c
> @@ -993,8 +993,8 @@ void machine_apply_elf_rel(struct mem_ehdr *ehdr,
> unsigned long r_type,
>   # define R_AARCH64_CALL26 283
>   #endif
>
> -       uint32_t *location = (uint32_t *)ptr;
> -       uint32_t data = *location;
> +       uint64_t *location = (uint64_t *)ptr;
> +       uint64_t data = *location;
>          const char *type = NULL;
>
>          switch(r_type) {
> @@ -1026,7 +1026,7 @@ void machine_apply_elf_rel(struct mem_ehdr *ehdr,
> unsigned long r_type,
>                  break;
>          }
>
> -       dbgprintf("%s: %s %x->%x\n", __func__, type, data, *location);
> +       dbgprintf("%s: %s %lx->%lx\n", __func__, type, data, *location);
>   }

Thanks for your help/pointer.

So, this was it. With above changes kexec reboot works fine with 
purgatory too.

By the way, how much execution time expected for verify_sha256_digest? I 
have not quantified, but it seems that it takes minutes to execute that.

~Pratyush

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
