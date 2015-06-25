Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1Z83vV-00081G-W8
 for kexec@lists.infradead.org; Thu, 25 Jun 2015 09:58:34 +0000
From: Vitaly Kuznetsov <vkuznets@redhat.com>
Subject: [PATCH v3 1/5] Drivers: hv: vmbus: remove hv_synic_free_cpu() call
 from hv_synic_cleanup()
Date: Thu, 25 Jun 2015 11:58:02 +0200
Message-Id: <1435226286-24842-2-git-send-email-vkuznets@redhat.com>
In-Reply-To: <1435226286-24842-1-git-send-email-vkuznets@redhat.com>
References: <1435226286-24842-1-git-send-email-vkuznets@redhat.com>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: devel@linuxdriverproject.org
Cc: Olaf Hering <olaf@aepfle.de>, Greg KH <gregkh@linuxfoundation.org>, Haiyang Zhang <haiyangz@microsoft.com>, x86@kernel.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>, Eric Biederman <ebiederm@xmission.com>, "H. Peter Anvin" <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>, "K. Y. Srinivasan" <kys@microsoft.com>

We already have hv_synic_free() which frees all per-cpu pages for all
CPUs, let's remove the hv_synic_free_cpu() call from hv_synic_cleanup()
so it will be possible to do separate cleanup (writing to MSRs) and final
freeing. This is going to be used to assist kexec.

Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
Signed-off-by: K. Y. Srinivasan <kys@microsoft.com>
---
 drivers/hv/hv.c        | 2 --
 drivers/hv/vmbus_drv.c | 1 +
 2 files changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/hv/hv.c b/drivers/hv/hv.c
index d3943bc..5b87042 100644
--- a/drivers/hv/hv.c
+++ b/drivers/hv/hv.c
@@ -530,6 +530,4 @@ void hv_synic_cleanup(void *arg)
 	rdmsrl(HV_X64_MSR_SCONTROL, sctrl.as_uint64);
 	sctrl.enable = 0;
 	wrmsrl(HV_X64_MSR_SCONTROL, sctrl.as_uint64);
-
-	hv_synic_free_cpu(cpu);
 }
diff --git a/drivers/hv/vmbus_drv.c b/drivers/hv/vmbus_drv.c
index cf20400..00d5158 100644
--- a/drivers/hv/vmbus_drv.c
+++ b/drivers/hv/vmbus_drv.c
@@ -1120,6 +1120,7 @@ static void __exit vmbus_exit(void)
 		tasklet_kill(hv_context.event_dpc[cpu]);
 		smp_call_function_single(cpu, hv_synic_cleanup, NULL, 1);
 	}
+	hv_synic_free();
 	acpi_bus_unregister_driver(&vmbus_acpi_driver);
 	hv_cpu_hotplug_quirk(false);
 }
-- 
2.4.2


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
