From: Mimi Zohar <zohar@linux.ibm.com>
Date: Sun, 13 Feb 2022 13:53:12 -0500
Subject: [PATCH v5 0/6] KEXEC_SIG with appended signature
In-Reply-To: <cover.1641900831.git.msuchanek@suse.de>
References: <cover.1641900831.git.msuchanek@suse.de>
Message-ID: <0278ab6a2891effd9b1eb8c0221769e332ec6082.camel@linux.ibm.com>
List-Id: <kexec.lists.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: kexec@lists.infradead.org

Hi Michal,

On Tue, 2022-01-11 at 12:37 +0100, Michal Suchanek wrote:
> Hello,
> 
> This is a refresh of the KEXEC_SIG series.

> This adds KEXEC_SIG support on powerpc and deduplicates the code dealing
> with appended signatures in the kernel.
> 
> powerpc supports IMA_KEXEC but that's an exception rather than the norm.
> On the other hand, KEXEC_SIG is portable across platforms.

This Kconfig carries the IMA measurement list across kexec.  This has
nothing to do with appended signatures.

config IMA_KEXEC
        bool "Enable carrying the IMA measurement list across a soft
boot"
        depends on IMA && TCG_TPM && HAVE_IMA_KEXEC

In addition to powerpc, arm64 sets HAVE_IMA_KEXEC.

Even prior to the kexec appended signature support, like all other
files, the kexec kernel image signature could be stored in
security.ima.

> 
> For distributions to have uniform security features across platforms one
> option should be used on all platforms.

The kexec kernel image measurement will not be included in the BIOS
event log.  Even if the measurement is included in the IMA measurement
list, without the IMA_KEXEC Kconfig the measurement list will not be
carried across kexec.  For those not interested in "trusted boot" or
those who do not need it for compliance, the simplification should be
fine.

-- 
thanks,

Mimi


