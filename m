Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-lf0-x242.google.com ([2a00:1450:4010:c07::242])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1fTzgV-0007Nn-MS
 for kexec@lists.infradead.org; Sat, 16 Jun 2018 01:07:21 +0000
Received: by mail-lf0-x242.google.com with SMTP id v135-v6so17031088lfa.9
 for <kexec@lists.infradead.org>; Fri, 15 Jun 2018 18:07:06 -0700 (PDT)
MIME-Version: 1.0
From: Andy Strohman <andy@uplevelsystems.com>
Date: Fri, 15 Jun 2018 18:07:04 -0700
Message-ID: <CAAGQ2nQNQ-aFkcrQHNA6H5TZ1tTovtfO_0Ohfndn9jXy13Hc6A@mail.gmail.com>
Subject: kexec failures on ipq4019
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
To: linux-arm-msm@vger.kernel.org, kexec@lists.infradead.org

Hi,

  I'm trying to get kexec to work consistently for ipq4019.  I load
the crash kernel like this:

kexec --type zImage -p zImage-initramfs
--dtb=image-qcom-ipq4019-eap1300.dtb --append="maxcpus=1
reset_devices" --image-size=34419456

  I have reserved 64MB of memory for the crash kernel with parameter:
crashkernel=64M

  This seems to work ~70% of the time. When it doesn't work, I see the
"bye!" message followed by a 5-10 second hang without output.  Then
the machine resets.

  I've been testing with:
echo c > /proc/sysrq-trigger

  Does anyone have an idea of what may be causing the failures or how
to troubleshoot this?

  I'm using OpenWRT with kernel 4.14.37.   I added the following patch
in order to load the crash kernel:

--- a/arch/arm/mach-qcom/platsmp.c
+++ b/arch/arm/mach-qcom/platsmp.c
@@ -332,6 +332,12 @@ static void __init qcom_smp_prepare_cpus
  }
 }

+/* Needed by kexec and platform_can_cpu_hotplug() */
+int qcom_cpu_kill(unsigned int cpu)
+{
+    return 1;
+}
+
 static const struct smp_operations smp_msm8660_ops __initconst = {
  .smp_prepare_cpus = qcom_smp_prepare_cpus,
  .smp_secondary_init = qcom_secondary_init,
@@ -358,6 +364,7 @@ static const struct smp_operations qcom_
  .smp_boot_secondary = kpssv2_boot_secondary,
 #ifdef CONFIG_HOTPLUG_CPU
  .cpu_die = qcom_cpu_die,
+    .cpu_kill       = qcom_cpu_kill,
 #endif
 };
 CPU_METHOD_OF_DECLARE(qcom_smp_kpssv2, "qcom,kpss-acc-v2",
&qcom_smp_kpssv2_ops);


Thanks,

Andy

-- 
http://www.uplevelsystems.com <http://www.uplevelsystems.com>




_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
