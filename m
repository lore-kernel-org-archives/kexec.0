Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-la0-f48.google.com ([209.85.215.48])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1XS717-0007oL-Kc
 for kexec@lists.infradead.org; Thu, 11 Sep 2014 16:14:44 +0000
Received: by mail-la0-f48.google.com with SMTP id ty20so11525299lab.35
 for <kexec@lists.infradead.org>; Thu, 11 Sep 2014 09:14:15 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <2d8dd1ea41dc51878dd4ce75de00eaec2518a76b.1410302383.git.geoff@infradead.org>
References: <cover.1410302383.git.geoff@infradead.org>
 <2d8dd1ea41dc51878dd4ce75de00eaec2518a76b.1410302383.git.geoff@infradead.org>
Date: Thu, 11 Sep 2014 21:44:13 +0530
Message-ID: <CAFdej01v7y+RDAoXUF8wg=PGoX81Ys-cX83NZgno+n3y4Up-eg@mail.gmail.com>
Subject: Re: [PATCH 03/13] arm64: Convert hcalls to use ISS field
From: Arun Chandran <achandran@mvista.com>
Content-Type: multipart/mixed; boundary=001a11c3f5c49b14050502cc75d4
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Geoff Levand <geoff@infradead.org>
Cc: Mark Rutland <mark.rutland@arm.com>, Marc Zyngier <marc.zyngier@arm.com>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, kexec@lists.infradead.org, Christoffer Dall <christoffer.dall@linaro.org>

--001a11c3f5c49b14050502cc75d4
Content-Type: text/plain; charset=UTF-8

Hi Geoff,
On Wed, Sep 10, 2014 at 4:19 AM, Geoff Levand <geoff@infradead.org> wrote:
> To allow for additional hcalls to be defined and to make the arm64 hcall API
> more consistent across exception vector routines change the hcall implementations
> to use the ISS field of the ESR_EL2 register to specify the hcall type.
>
> The existing arm64 hcall implementations are limited in that they only allow
> for two distinct hcalls; with the x0 register either zero, or not zero.  Also,
> the API of the hyp-stub exception vector routines and the KVM exception vector
> routines differ; hyp-stub uses a non-zero value in x0 to implement
> __hyp_set_vectors, whereas KVM uses it to implement kvm_call_hyp.
>
> Define three new preprocessor macros HVC_GET_VECTORS, HVC_SET_VECTORS and
> HVC_KVM_CALL_HYP and to be used as hcall type specifiers and convert the
> existing __hyp_get_vectors(), __hyp_set_vectors() and kvm_call_hyp() routines
> to use these new macros when executing and HVC call.  Also change the
> corresponding hyp-stub and KVM el1_sync exception vector routines to use these
> new macros.
>

What about using a more simplified approach like below.
I was able to use your kexec tree and successfully boot
KVM/ ~KVM combinations with this patch (patch attached).

########################
diff --git a/arch/arm64/include/asm/virt.h b/arch/arm64/include/asm/virt.h
index 7a5df52..264d451 100644
--- a/arch/arm64/include/asm/virt.h
+++ b/arch/arm64/include/asm/virt.h
@@ -37,6 +37,8 @@ extern u32 __boot_cpu_mode[2];
 void __hyp_set_vectors(phys_addr_t phys_vector_base);
 phys_addr_t __hyp_get_vectors(void);

+void __hyp_kexec_final_call(unsigned long func_addr) __attribute__((noreturn));
+
 /* Reports the availability of HYP mode */
 static inline bool is_hyp_mode_available(void)
 {
diff --git a/arch/arm64/kernel/hyp-stub.S b/arch/arm64/kernel/hyp-stub.S
index a272f33..456af5b 100644
--- a/arch/arm64/kernel/hyp-stub.S
+++ b/arch/arm64/kernel/hyp-stub.S
@@ -52,16 +52,30 @@ ENDPROC(__hyp_stub_vectors)

  .align 11

+#define ESR_EL2_EC_SHIFT 26
+#define ESR_EL2_EC_HVC64 0x16
+#define ESR_EL2_ISS 0xffff
+#define KEXEC_FINAL_CALL 0xffff
+
 el1_sync:
- mrs x1, esr_el2
- lsr x1, x1, #26
- cmp x1, #0x16
- b.ne 2f // Not an HVC trap
- cbz x0, 1f
- msr vbar_el2, x0 // Set vbar_el2
- b 2f
-1: mrs x0, vbar_el2 // Return vbar_el2
-2: eret
+ mrs     x10, esr_el2
+ lsr     x9, x10, #ESR_EL2_EC_SHIFT      // x9=EC
+ and     x10, x10, #ESR_EL2_ISS          // x10=ISS
+
+ cmp     x9, #ESR_EL2_EC_HVC64
+ b.ne    4f                              // Not a host HVC trap
+
+ cbnz x10, 3f // kexec final call
+ cbz x0, 2f
+
+1: msr vbar_el2, x0 // Set vbar_el2
+ eret
+
+2: mrs x0, vbar_el2 // Return vbar_el2
+ eret
+
+3: br x0
+4: eret
 ENDPROC(el1_sync)

 .macro invalid_vector label
@@ -99,12 +113,18 @@ ENDPROC(\label)
  * so you will need to set that to something sensible at the new hypervisor's
  * initialisation entry point.
  */
-
 ENTRY(__hyp_get_vectors)
  mov x0, xzr
- // fall through
-ENTRY(__hyp_set_vectors)
  hvc #0
  ret
 ENDPROC(__hyp_get_vectors)
+
+ENTRY(__hyp_set_vectors)
+ hvc #0
+ ret
 ENDPROC(__hyp_set_vectors)
+
+/* x0 -> final kexec cleanup func addr */
+ENTRY(__hyp_kexec_final_call)
+ hvc #KEXEC_FINAL_CALL
+ENDPROC(__hyp_kexec_final_call)
diff --git a/arch/arm64/kvm/hyp.S b/arch/arm64/kvm/hyp.S
index b72aa9f..b5803e3 100644
--- a/arch/arm64/kvm/hyp.S
+++ b/arch/arm64/kvm/hyp.S
@@ -1135,16 +1135,20 @@ ENDPROC(\label)
  invalid_vector el1_fiq_invalid, __kvm_hyp_panic
  invalid_vector el1_error_invalid, __kvm_hyp_panic

+#define ESR_EL2_ISS 0xffff
 el1_sync: // Guest trapped into EL2
  push x0, x1
  push x2, x3

  mrs x1, esr_el2
+ and     x0, x1, #ESR_EL2_ISS
  lsr x2, x1, #ESR_EL2_EC_SHIFT

  cmp x2, #ESR_EL2_EC_HVC64
  b.ne el1_trap

+ cbnz x0, 3f // final kexec call
+
  mrs x3, vttbr_el2 // If vttbr is valid, the 64bit guest
  cbnz x3, el1_trap // called HVC

@@ -1159,6 +1163,7 @@ el1_sync: // Guest trapped into EL2

 1: push lr, xzr

+
  /*
  * Compute the function address in EL2, and shuffle the parameters.
  */
@@ -1172,6 +1177,17 @@ el1_sync: // Guest trapped into EL2
  pop lr, xzr
 2: eret

+ /* Call the kexec clean up function */
+3: pop x2, x3
+ pop x0, x1
+ /* Stage-2 translation */
+ msr vttbr_el2, xzr
+ mrs x1, sctlr_el2
+ bic x1, x1, #1
+ msr sctlr_el2, x1 // disable the MMU
+ isb
+ br x0
+
 el1_trap:
  /*
  * x1: ESR
diff --git a/arch/arm64/mm/proc.S b/arch/arm64/mm/proc.S
index 3cb6dec..b961482 100644
--- a/arch/arm64/mm/proc.S
+++ b/arch/arm64/mm/proc.S
@@ -25,6 +25,7 @@
 #include <asm/hwcap.h>
 #include <asm/pgtable-hwdef.h>
 #include <asm/pgtable.h>
+#include <asm/virt.h>

 #include "proc-macros.S"

@@ -69,19 +70,33 @@ ENDPROC(cpu_cache_off)
  */
  .align 5
 ENTRY(cpu_reset)
+ mov x19, x0
+ adr x0, hyp_final_cleanup
+ sub w1, w1, #BOOT_CPU_MODE_EL2
+ cbz w1, __hyp_kexec_final_call
  ret x0
 ENDPROC(cpu_reset)

+ENTRY(hyp_final_cleanup)
+ /* Need to do the final EL2 clean up here */
+ br x19
+ENDPROC(hyp_final_cleanup)
+

##########################

--Arun



> Signed-off-by: Geoff Levand <geoff@infradead.org>
> ---
>  arch/arm64/include/asm/virt.h | 20 ++++++++++++++++++++
>  arch/arm64/kernel/hyp-stub.S  | 38 ++++++++++++++++++++++++++------------
>  arch/arm64/kvm/hyp.S          | 19 ++++++++++++-------
>  3 files changed, 58 insertions(+), 19 deletions(-)
>
> diff --git a/arch/arm64/include/asm/virt.h b/arch/arm64/include/asm/virt.h
> index 7a5df52..894fe53 100644
> --- a/arch/arm64/include/asm/virt.h
> +++ b/arch/arm64/include/asm/virt.h
> @@ -21,6 +21,26 @@
>  #define BOOT_CPU_MODE_EL1      (0xe11)
>  #define BOOT_CPU_MODE_EL2      (0xe12)
>
> +/*
> + * HVC_GET_VECTORS - Return the value of the vbar_el2 register.
> + */
> +
> +#define HVC_GET_VECTORS 1
> +
> +/*
> + * HVC_SET_VECTORS - Set the value of the vbar_el2 register.
> + *
> + * @x0: Physical address of the new vector table.
> + */
> +
> +#define HVC_SET_VECTORS 2
> +
> +/*
> + * HVC_KVM_CALL_HYP - Execute kvm_call_hyp routine.
> + */
> +
> +#define HVC_KVM_CALL_HYP 3
> +
>  #ifndef __ASSEMBLY__
>
>  /*
> diff --git a/arch/arm64/kernel/hyp-stub.S b/arch/arm64/kernel/hyp-stub.S
> index 2d960a9..9ab5f70 100644
> --- a/arch/arm64/kernel/hyp-stub.S
> +++ b/arch/arm64/kernel/hyp-stub.S
> @@ -54,16 +54,29 @@ ENDPROC(__hyp_stub_vectors)
>
>  #define ESR_EL2_EC_SHIFT       26
>  #define ESR_EL2_EC_HVC64       0x16
> +#define ESR_EL2_ISS            0xffff
>
>  el1_sync:
> -       mrs     x1, esr_el2
> -       lsr     x1, x1, #ESR_EL2_EC_SHIFT
> -       cmp     x1, #ESR_EL2_EC_HVC64
> -       b.ne    2f                              // Not an HVC trap
> -       cbz     x0, 1f
> -       msr     vbar_el2, x0                    // Set vbar_el2
> +       mrs     x10, esr_el2
> +       lsr     x9, x10, #ESR_EL2_EC_SHIFT      // x9=EC
> +       and     x10, x10, #ESR_EL2_ISS          // x10=ISS
> +
> +       cmp     x9, #ESR_EL2_EC_HVC64
> +       b.ne    2f                              // Not a host HVC trap
> +
> +       mrs     x9, vttbr_el2
> +       cbnz    x9, 2f                          // Not a host HVC trap
> +
> +       cmp     x10, #HVC_GET_VECTORS
> +       b.ne    1f
> +       mrs     x0, vbar_el2
>         b       2f
> -1:     mrs     x0, vbar_el2                    // Return vbar_el2
> +
> +1:     cmp     x10, #HVC_SET_VECTORS
> +       b.ne    1f
> +       msr     vbar_el2, x0
> +
> +1:
>  2:     eret
>  ENDPROC(el1_sync)
>
> @@ -103,11 +116,12 @@ ENDPROC(\label)
>   * initialisation entry point.
>   */
>
> -ENTRY(__hyp_get_vectors)
> -       mov     x0, xzr
> -       // fall through
>  ENTRY(__hyp_set_vectors)
> -       hvc     #0
> +       hvc     #HVC_SET_VECTORS
>         ret
> -ENDPROC(__hyp_get_vectors)
>  ENDPROC(__hyp_set_vectors)
> +
> +ENTRY(__hyp_get_vectors)
> +       hvc     #HVC_GET_VECTORS
> +       ret
> +ENDPROC(__hyp_get_vectors)
> diff --git a/arch/arm64/kvm/hyp.S b/arch/arm64/kvm/hyp.S
> index b72aa9f..3972ee9 100644
> --- a/arch/arm64/kvm/hyp.S
> +++ b/arch/arm64/kvm/hyp.S
> @@ -26,6 +26,7 @@
>  #include <asm/kvm_asm.h>
>  #include <asm/kvm_arm.h>
>  #include <asm/kvm_mmu.h>
> +#include <asm/virt.h>
>
>  #define CPU_GP_REG_OFFSET(x)   (CPU_GP_REGS + x)
>  #define CPU_XREG_OFFSET(x)     CPU_GP_REG_OFFSET(CPU_USER_PT_REGS + 8*x)
> @@ -1105,12 +1106,9 @@ __hyp_panic_str:
>   * in Hyp mode (see init_hyp_mode in arch/arm/kvm/arm.c).  Return values are
>   * passed in r0 and r1.
>   *
> - * A function pointer with a value of 0 has a special meaning, and is
> - * used to implement __hyp_get_vectors in the same way as in
> - * arch/arm64/kernel/hyp_stub.S.
>   */
>  ENTRY(kvm_call_hyp)
> -       hvc     #0
> +       hvc     #HVC_KVM_CALL_HYP
>         ret
>  ENDPROC(kvm_call_hyp)
>
> @@ -1140,6 +1138,7 @@ el1_sync:                                 // Guest trapped into EL2
>         push    x2, x3
>
>         mrs     x1, esr_el2
> +       and     x0, x1, #ESR_EL2_ISS
>         lsr     x2, x1, #ESR_EL2_EC_SHIFT
>
>         cmp     x2, #ESR_EL2_EC_HVC64
> @@ -1149,15 +1148,19 @@ el1_sync:                                       // Guest trapped into EL2
>         cbnz    x3, el1_trap                    // called HVC
>
>         /* Here, we're pretty sure the host called HVC. */
> +       mov     x10, x0
>         pop     x2, x3
>         pop     x0, x1
>
> -       /* Check for __hyp_get_vectors */
> -       cbnz    x0, 1f
> +       cmp     x10, #HVC_GET_VECTORS
> +       b.ne    1f
>         mrs     x0, vbar_el2
>         b       2f
>
> -1:     push    lr, xzr
> +1:     cmp     x10, #HVC_KVM_CALL_HYP
> +       b.ne    1f
> +
> +       push    lr, xzr
>
>         /*
>          * Compute the function address in EL2, and shuffle the parameters.
> @@ -1170,6 +1173,8 @@ el1_sync:                                 // Guest trapped into EL2
>         blr     lr
>
>         pop     lr, xzr
> +
> +1:
>  2:     eret
>
>  el1_trap:
> --
> 1.9.1
>
>
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--001a11c3f5c49b14050502cc75d4
Content-Type: application/octet-stream; name=kexec_patch
Content-Disposition: attachment; filename=kexec_patch
Content-Transfer-Encoding: base64
X-Attachment-Id: f_hzyaonrt0

ZGlmZiAtLWdpdCBhL2FyY2gvYXJtNjQvaW5jbHVkZS9hc20vdmlydC5oIGIvYXJjaC9hcm02NC9p
bmNsdWRlL2FzbS92aXJ0LmgKaW5kZXggN2E1ZGY1Mi4uMjY0ZDQ1MSAxMDA2NDQKLS0tIGEvYXJj
aC9hcm02NC9pbmNsdWRlL2FzbS92aXJ0LmgKKysrIGIvYXJjaC9hcm02NC9pbmNsdWRlL2FzbS92
aXJ0LmgKQEAgLTM3LDYgKzM3LDggQEAgZXh0ZXJuIHUzMiBfX2Jvb3RfY3B1X21vZGVbMl07CiB2
b2lkIF9faHlwX3NldF92ZWN0b3JzKHBoeXNfYWRkcl90IHBoeXNfdmVjdG9yX2Jhc2UpOwogcGh5
c19hZGRyX3QgX19oeXBfZ2V0X3ZlY3RvcnModm9pZCk7CiAKK3ZvaWQgX19oeXBfa2V4ZWNfZmlu
YWxfY2FsbCh1bnNpZ25lZCBsb25nIGZ1bmNfYWRkcikgX19hdHRyaWJ1dGVfXygobm9yZXR1cm4p
KTsKKwogLyogUmVwb3J0cyB0aGUgYXZhaWxhYmlsaXR5IG9mIEhZUCBtb2RlICovCiBzdGF0aWMg
aW5saW5lIGJvb2wgaXNfaHlwX21vZGVfYXZhaWxhYmxlKHZvaWQpCiB7CmRpZmYgLS1naXQgYS9h
cmNoL2FybTY0L2tlcm5lbC9oeXAtc3R1Yi5TIGIvYXJjaC9hcm02NC9rZXJuZWwvaHlwLXN0dWIu
UwppbmRleCBhMjcyZjMzLi40NTZhZjViIDEwMDY0NAotLS0gYS9hcmNoL2FybTY0L2tlcm5lbC9o
eXAtc3R1Yi5TCisrKyBiL2FyY2gvYXJtNjQva2VybmVsL2h5cC1zdHViLlMKQEAgLTUyLDE2ICs1
MiwzMCBAQCBFTkRQUk9DKF9faHlwX3N0dWJfdmVjdG9ycykKIAogCS5hbGlnbiAxMQogCisjZGVm
aW5lIEVTUl9FTDJfRUNfU0hJRlQJMjYKKyNkZWZpbmUgRVNSX0VMMl9FQ19IVkM2NAkweDE2Cisj
ZGVmaW5lIEVTUl9FTDJfSVNTCQkweGZmZmYKKyNkZWZpbmUgS0VYRUNfRklOQUxfQ0FMTAkweGZm
ZmYKKwogZWwxX3N5bmM6Ci0JbXJzCXgxLCBlc3JfZWwyCi0JbHNyCXgxLCB4MSwgIzI2Ci0JY21w
CXgxLCAjMHgxNgotCWIubmUJMmYJCQkJLy8gTm90IGFuIEhWQyB0cmFwCi0JY2J6CXgwLCAxZgot
CW1zcgl2YmFyX2VsMiwgeDAJCQkvLyBTZXQgdmJhcl9lbDIKLQliCTJmCi0xOgltcnMJeDAsIHZi
YXJfZWwyCQkJLy8gUmV0dXJuIHZiYXJfZWwyCi0yOgllcmV0CisJbXJzICAgICB4MTAsIGVzcl9l
bDIKKwlsc3IgICAgIHg5LCB4MTAsICNFU1JfRUwyX0VDX1NISUZUICAgICAgLy8geDk9RUMKKwlh
bmQgICAgIHgxMCwgeDEwLCAjRVNSX0VMMl9JU1MgICAgICAgICAgLy8geDEwPUlTUworCisJY21w
ICAgICB4OSwgI0VTUl9FTDJfRUNfSFZDNjQKKwliLm5lICAgIDRmICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgLy8gTm90IGEgaG9zdCBIVkMgdHJhcAorCisJY2Juegl4MTAsIDNmCQkJCS8v
IGtleGVjIGZpbmFsIGNhbGwKKwljYnoJeDAsIDJmCisKKzE6CW1zcgl2YmFyX2VsMiwgeDAJCQkv
LyBTZXQgdmJhcl9lbDIKKwllcmV0CisKKzI6CW1ycwl4MCwgdmJhcl9lbDIJCQkvLyBSZXR1cm4g
dmJhcl9lbDIKKwllcmV0CisKKzM6CWJyCXgwCis0OgllcmV0CiBFTkRQUk9DKGVsMV9zeW5jKQog
CiAubWFjcm8gaW52YWxpZF92ZWN0b3IJbGFiZWwKQEAgLTk5LDEyICsxMTMsMTggQEAgRU5EUFJP
QyhcbGFiZWwpCiAgKiBzbyB5b3Ugd2lsbCBuZWVkIHRvIHNldCB0aGF0IHRvIHNvbWV0aGluZyBz
ZW5zaWJsZSBhdCB0aGUgbmV3IGh5cGVydmlzb3IncwogICogaW5pdGlhbGlzYXRpb24gZW50cnkg
cG9pbnQuCiAgKi8KLQogRU5UUlkoX19oeXBfZ2V0X3ZlY3RvcnMpCiAJbW92CXgwLCB4enIKLQkv
LyBmYWxsIHRocm91Z2gKLUVOVFJZKF9faHlwX3NldF92ZWN0b3JzKQogCWh2YwkjMAogCXJldAog
RU5EUFJPQyhfX2h5cF9nZXRfdmVjdG9ycykKKworRU5UUlkoX19oeXBfc2V0X3ZlY3RvcnMpCisJ
aHZjCSMwCisJcmV0CiBFTkRQUk9DKF9faHlwX3NldF92ZWN0b3JzKQorCisvKiB4MCAtPiBmaW5h
bCBrZXhlYyBjbGVhbnVwIGZ1bmMgYWRkciAqLworRU5UUlkoX19oeXBfa2V4ZWNfZmluYWxfY2Fs
bCkKKwlodmMJI0tFWEVDX0ZJTkFMX0NBTEwKK0VORFBST0MoX19oeXBfa2V4ZWNfZmluYWxfY2Fs
bCkKZGlmZiAtLWdpdCBhL2FyY2gvYXJtNjQva3ZtL2h5cC5TIGIvYXJjaC9hcm02NC9rdm0vaHlw
LlMKaW5kZXggYjcyYWE5Zi4uYjU4MDNlMyAxMDA2NDQKLS0tIGEvYXJjaC9hcm02NC9rdm0vaHlw
LlMKKysrIGIvYXJjaC9hcm02NC9rdm0vaHlwLlMKQEAgLTExMzUsMTYgKzExMzUsMjAgQEAgRU5E
UFJPQyhcbGFiZWwpCiAJaW52YWxpZF92ZWN0b3IJZWwxX2ZpcV9pbnZhbGlkLCBfX2t2bV9oeXBf
cGFuaWMKIAlpbnZhbGlkX3ZlY3RvcgllbDFfZXJyb3JfaW52YWxpZCwgX19rdm1faHlwX3Bhbmlj
CiAKKyNkZWZpbmUgRVNSX0VMMl9JU1MJCTB4ZmZmZgogZWwxX3N5bmM6CQkJCQkvLyBHdWVzdCB0
cmFwcGVkIGludG8gRUwyCiAJcHVzaAl4MCwgeDEKIAlwdXNoCXgyLCB4MwogCiAJbXJzCXgxLCBl
c3JfZWwyCisJYW5kICAgICB4MCwgeDEsICNFU1JfRUwyX0lTUwogCWxzcgl4MiwgeDEsICNFU1Jf
RUwyX0VDX1NISUZUCiAKIAljbXAJeDIsICNFU1JfRUwyX0VDX0hWQzY0CiAJYi5uZQllbDFfdHJh
cAogCisJY2Juegl4MCwgM2YJCQkJLy8gZmluYWwga2V4ZWMgY2FsbAorCiAJbXJzCXgzLCB2dHRi
cl9lbDIJCQkvLyBJZiB2dHRiciBpcyB2YWxpZCwgdGhlIDY0Yml0IGd1ZXN0CiAJY2Juegl4Mywg
ZWwxX3RyYXAJCQkvLyBjYWxsZWQgSFZDCiAKQEAgLTExNTksNiArMTE2Myw3IEBAIGVsMV9zeW5j
OgkJCQkJLy8gR3Vlc3QgdHJhcHBlZCBpbnRvIEVMMgogCiAxOglwdXNoCWxyLCB4enIKIAorCiAJ
LyoKIAkgKiBDb21wdXRlIHRoZSBmdW5jdGlvbiBhZGRyZXNzIGluIEVMMiwgYW5kIHNodWZmbGUg
dGhlIHBhcmFtZXRlcnMuCiAJICovCkBAIC0xMTcyLDYgKzExNzcsMTcgQEAgZWwxX3N5bmM6CQkJ
CQkvLyBHdWVzdCB0cmFwcGVkIGludG8gRUwyCiAJcG9wCWxyLCB4enIKIDI6CWVyZXQKIAorCS8q
IENhbGwgdGhlIGtleGVjIGNsZWFuIHVwIGZ1bmN0aW9uICovCiszOglwb3AJeDIsIHgzCisJcG9w
CXgwLCB4MQorCS8qIFN0YWdlLTIgdHJhbnNsYXRpb24gKi8KKwltc3IJdnR0YnJfZWwyLCB4enIK
KwltcnMJeDEsIHNjdGxyX2VsMgorCWJpYwl4MSwgeDEsICMxCisJbXNyCXNjdGxyX2VsMiwgeDEJ
CQkvLyBkaXNhYmxlIHRoZSBNTVUKKwlpc2IKKwlicgl4MAorCiBlbDFfdHJhcDoKIAkvKgogCSAq
IHgxOiBFU1IKZGlmZiAtLWdpdCBhL2FyY2gvYXJtNjQvbW0vcHJvYy5TIGIvYXJjaC9hcm02NC9t
bS9wcm9jLlMKaW5kZXggM2NiNmRlYy4uYjk2MTQ4MiAxMDA2NDQKLS0tIGEvYXJjaC9hcm02NC9t
bS9wcm9jLlMKKysrIGIvYXJjaC9hcm02NC9tbS9wcm9jLlMKQEAgLTI1LDYgKzI1LDcgQEAKICNp
bmNsdWRlIDxhc20vaHdjYXAuaD4KICNpbmNsdWRlIDxhc20vcGd0YWJsZS1od2RlZi5oPgogI2lu
Y2x1ZGUgPGFzbS9wZ3RhYmxlLmg+CisjaW5jbHVkZSA8YXNtL3ZpcnQuaD4KIAogI2luY2x1ZGUg
InByb2MtbWFjcm9zLlMiCiAKQEAgLTY5LDE5ICs3MCwzMyBAQCBFTkRQUk9DKGNwdV9jYWNoZV9v
ZmYpCiAgKi8KIAkuYWxpZ24JNQogRU5UUlkoY3B1X3Jlc2V0KQorCW1vdgl4MTksIHgwCisJYWRy
CXgwLCBoeXBfZmluYWxfY2xlYW51cAorCXN1Ygl3MSwgdzEsICNCT09UX0NQVV9NT0RFX0VMMgor
CWNiegl3MSwgX19oeXBfa2V4ZWNfZmluYWxfY2FsbAogCXJldAl4MAogRU5EUFJPQyhjcHVfcmVz
ZXQpCiAKK0VOVFJZKGh5cF9maW5hbF9jbGVhbnVwKQorCS8qIE5lZWQgdG8gZG8gdGhlIGZpbmFs
IEVMMiBjbGVhbiB1cCBoZXJlICovCisJYnIJeDE5CitFTkRQUk9DKGh5cF9maW5hbF9jbGVhbnVw
KQorCg==
--001a11c3f5c49b14050502cc75d4
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

--001a11c3f5c49b14050502cc75d4--

