Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1aIvg7-0001lQ-Rg
 for kexec@lists.infradead.org; Tue, 12 Jan 2016 09:55:52 +0000
Date: Tue, 12 Jan 2016 15:25:28 +0530
From: Pratyush Anand <panand@redhat.com>
Subject: Re: [PATCH RFC V2 2/2] arm64: Pass RAM boundary and enable-dcache
 flag to purgatory
Message-ID: <20160112095528.GK21206@dhcppc13.redhat.com>
References: <cover.1452572612.git.panand@redhat.com>
 <062475cf4f3fbe34c4165e58ebad5a370e3a3b8b.1452572612.git.panand@redhat.com>
 <5694BB9F.5050801@linaro.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <5694BB9F.5050801@linaro.org>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: AKASHI Takahiro <takahiro.akashi@linaro.org>
Cc: geoff@infradead.org, kexec@lists.infradead.org, horms@verge.net.au, james.morse@arm.com, jk@ozlabs.org, scottwood@freescale.com, dyoung@redhat.com, vgoyal@redhat.com, ebiederm@xmission.com

Hi Akashi,

On 12/01/2016:05:38:55 PM, AKASHI Takahiro wrote:
> On 01/12/2016 02:12 PM, Pratyush Anand wrote:
> >When "enable-dcache" is passed to the kexec() command line, kexec-tools
> >passes this information to purgatory, which in turn enables cache during
> >sha-256 verification.
> >
> >RAM boundary which includes all the sections is needed for creating
> >identity page mapping and to enable d-cache for those areas. Therefore
> >these informations are passed to purgatory as well.
> >
> >Signed-off-by: Pratyush Anand <panand@redhat.com>
> >---
> >  kexec/arch/arm64/include/arch/options.h |  6 +++++-
> >  kexec/arch/arm64/include/types.h        | 16 ++++++++++++++++
> >  kexec/arch/arm64/kexec-arm64.c          | 24 +++++++++++++++++++++++-
> >  purgatory/arch/arm64/entry.S            | 15 +++++++++++++++
> >  purgatory/arch/arm64/purgatory-arm64.c  | 10 +++++++++-
> >  5 files changed, 68 insertions(+), 3 deletions(-)
> >  create mode 100644 kexec/arch/arm64/include/types.h
> >
> >diff --git a/kexec/arch/arm64/include/arch/options.h b/kexec/arch/arm64/include/arch/options.h
> >index fbe17de595a9..3d84bb12ee37 100644
> >--- a/kexec/arch/arm64/include/arch/options.h
> >+++ b/kexec/arch/arm64/include/arch/options.h
> >@@ -8,7 +8,8 @@
> >  #define OPT_PORT		((OPT_MAX)+4)
> >  #define OPT_REUSE_CMDLINE	((OPT_MAX)+5)
> >  #define OPT_PORT_LSR		((OPT_MAX)+6)
> >-#define OPT_ARCH_MAX		((OPT_MAX)+7)
> >+#define OPT_ENABLE_DCACHE	((OPT_MAX)+7)
> >+#define OPT_ARCH_MAX		((OPT_MAX)+8)
> >
> >  #define KEXEC_ARCH_OPTIONS \
> >  	KEXEC_OPTIONS \
> >@@ -20,6 +21,7 @@
> >  	{ "port",         1, NULL, OPT_PORT }, \
> >  	{ "port-lsr",     1, NULL, OPT_PORT_LSR }, \
> >  	{ "ramdisk",      1, NULL, OPT_INITRD }, \
> >+	{ "enable-dcache", 0, NULL, OPT_ENABLE_DCACHE }, \
> 
> in alphabetical order, please.

OK

> 
> >  	{ "reuse-cmdline", 0, NULL, OPT_REUSE_CMDLINE }, \
> >
> >  #define KEXEC_ARCH_OPT_STR KEXEC_OPT_STR /* Only accept long arch options. */
> >@@ -33,6 +35,7 @@ static const char arm64_opts_usage[] __attribute__ ((unused)) =
> >  "     --initrd=FILE         Use FILE as the kernel initial ramdisk.\n"
> >  "     --port=ADDRESS        Purgatory output to port ADDRESS.\n"
> >  "     --port-lsr=ADDR,VAL   Purgatory output port line status address and TX Empty Bit Field.\n"
> >+"     --enable-dcache       Enable D-Cache in Purgatory for faster SHA verification.\n"
> 
> ditto :)

OK.

Thanks for quick review.
Will wait for some time to get more feedback and then will send next version.

~Pratyush

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
