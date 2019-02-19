Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
From: Kazuhito Hagio <k-hagio@ab.jp.nec.com>
Subject: RE: [PATCH] arm64, vmcoreinfo : Append 'MAX_USER_VA_BITS' and
 'MAX_PHYSMEM_BITS' to vmcoreinfo
Date: Tue, 19 Feb 2019 20:47:17 +0000
Message-ID: <4AE2DC15AC0B8543882A74EA0D43DBEC03568A9F@BPXM09GP.gisp.nec.co.jp>
References: <1548850991-11879-1-git-send-email-bhsharma@redhat.com>
 <20190131014800.GB15785@dhcp-128-65.nay.redhat.com>
 <4AE2DC15AC0B8543882A74EA0D43DBEC03567AA3@BPXM09GP.gisp.nec.co.jp>
 <d7d50b5a-3577-448e-d928-7898016a38fb@redhat.com>
 <20190212104407.GA17022@dhcp-128-65.nay.redhat.com>
 <CACi5LpOAADU8s+3e6=fO7FT+VtAmWYNeZN9COF+4Gt6twLWYaA@mail.gmail.com>
 <4AE2DC15AC0B8543882A74EA0D43DBEC035683DB@BPXM09GP.gisp.nec.co.jp>
 <20190213111552.GA8265@dhcp-128-65.nay.redhat.com>
 <bed51e6e-3dcb-8e07-1d31-9d81bfca20e5@arm.com>
 <4AE2DC15AC0B8543882A74EA0D43DBEC03568504@BPXM09GP.gisp.nec.co.jp>
 <37ed4c14-e4b9-49c0-4816-c289ce65fd76@arm.com>
 <CACi5LpN6gVy4gCTYLGRiWW1VNGrVc-+Ykn919LKsO2bP-v1NHw@mail.gmail.com>
In-Reply-To: <CACi5LpN6gVy4gCTYLGRiWW1VNGrVc-+Ykn919LKsO2bP-v1NHw@mail.gmail.com>
Content-Language: en-US
MIME-Version: 1.0
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
To: Bhupesh Sharma <bhsharma@redhat.com>
Cc: Mark Rutland <mark.rutland@arm.com>, "lijiang@redhat.com" <lijiang@redhat.com>, "bhe@redhat.com" <bhe@redhat.com>, "ard.biesheuvel@linaro.org" <ard.biesheuvel@linaro.org>, "catalin.marinas@arm.com" <catalin.marinas@arm.com>, Steve Capper <Steve.Capper@arm.com>, "kexec@lists.infradead.org" <kexec@lists.infradead.org>, Will Deacon <will.deacon@arm.com>, AKASHI Takahiro <takahiro.akashi@linaro.org>, James Morse <james.morse@arm.com>, Kristina Martsenko <kristina.martsenko@arm.com>, Borislav Petkov <bp@alien8.de>, "anderson@redhat.com" <anderson@redhat.com>, Dave Young <dyoung@redhat.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

Hi Bhupesh,

-----Original Message-----
> I am not sure you got a chance to look at the two regression cases I
> reported here:
> <http://lists.infradead.org/pipermail/kexec/2019-February/022449.html>
> 
> Unfortunately the above suggestion doesn't provide any fix for
> ARMv8.2-LPA regression (see text under heading '
> (1). Regression Case 1 (ARMv8.2-LPA enabled kernel)')

As for MAX_PHYSMEM_BITS, I realized that ppc64 makedumpfile can detect
it because there is only one SECTION_SIZE_BITS for ppc64. I think we
can use the same way as set_ppc64_max_physmem_bits() does also for
arm64 for now. I'm going to write it for kernels not having
NUMBER(MAX_PHYSMEM_BITS) in vmcoreinfo.

Thanks,
Kazu

> 
> After going through the regression reports, I think exporting
> 'MAX_USER_VA_BITS' and 'MAX_PHYSMEM_BITS' to vmcoreinfo is sufficient
> for the above regressions (without over-complicating the stuff) as
> ARM64_TCR.T1SZ and friends seem to arch specific as compared to
> VA_BITS + 'MAX_USER_VA_BITS' .
> 
> Thanks,
> Bhupesh
_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
