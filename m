Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9152C43334
	for <kexec@archiver.kernel.org>; Wed, 20 Jul 2022 06:03:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=c1XbnRnFMZMWeQj2nXX1Hy8tGD7bD5YLh4IHSJ+jztk=; b=DUHJcxxhV5M3PI
	OBiDVedh7BSR2W76JJxJYqc2ack7Wj5cfr0g7DxJlTdoV0O5V2GChG3Sy4JusSEAYut7jC944hyn5
	OX/PSBxffNo7WwG7FPgv4iE+zNh4dWn9EbvjZ5dLBSA+uV53scVK6e+OcuzY3lrn0/rcQkjAHJBJx
	z/A0f0jbPThAXaL7dvcDYgWUenq8WPXLdo+AXjUK3rdNxjdkTGHGZ0w9c4A4GmJrRNFM6PeRwYEDt
	3/r7d47UuYx0Izgu9BSMh13iPhr7uKlSNWppmPGFbUhNlbVBpuasWKyCxCMtcpeaAzTpboB/v/VBi
	wJv3WMRklEgglYx+b5uQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oE2nd-000sZX-T6; Wed, 20 Jul 2022 06:03:09 +0000
Received: from fanzine.igalia.com ([178.60.130.6] helo=fanzine2.igalia.com)
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oDtLo-00CCol-SJ
	for kexec@lists.infradead.org; Tue, 19 Jul 2022 19:57:50 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=C1vK0PqoODM7/n3gyOjq8NgLf2lP/RehFU6zSZW0fzc=; b=f8EgDLqs9fiPg4nZcLPm2GylL6
	GFiz2gnwuYyiUCMoOS3M5WoxW0K7sMN+Cn+RmnEfBcUIkDF/iK0gKF6SgYUgJ+072EfoKnczRB48j
	BtwV0OZzs3Z8d/bVifZPOFuRdkj5FanoI960l5fzfpk65Qmhs50r9Al4ujbJl7o86Mxhu1neT50Cs
	JY/nYTfazCtM3N+sEuP0oIe0o+9kqt01LGBKy2PImvVrGX3yzYNS9Fmp8pOyD8BpXan3hJYt6Sm2V
	5iOhIzgUuSmXCszoMXx888rxqJKWrWLOVLz8N4rW7By+H9A50m0UF0iRO2e92fJAKpvpKdQg6ReHo
	w5iA5ShQ==;
Received: from 200-100-212-117.dial-up.telesp.net.br ([200.100.212.117] helo=localhost)
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1oDtLj-006fen-Cd; Tue, 19 Jul 2022 21:57:44 +0200
From: "Guilherme G. Piccoli" <gpiccoli@igalia.com>
To: akpm@linux-foundation.org,
	bhe@redhat.com,
	pmladek@suse.com,
	kexec@lists.infradead.org
Subject: [PATCH v2 11/13] video/hyperv_fb: Avoid taking busy spinlock on panic path
Date: Tue, 19 Jul 2022 16:53:24 -0300
Message-Id: <20220719195325.402745-12-gpiccoli@igalia.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220719195325.402745-1-gpiccoli@igalia.com>
References: <20220719195325.402745-1-gpiccoli@igalia.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220719_125748_970199_DD142F8B 
X-CRM114-Status: GOOD (  14.87  )
X-Mailman-Approved-At: Tue, 19 Jul 2022 23:02:40 -0700
X-BeenThere: kexec@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Cc: linux-hyperv@vger.kernel.org, halves@canonical.com, peterz@infradead.org, dave.hansen@linux.intel.com, feng.tang@intel.com, mikelley@microsoft.com, "K. Y. Srinivasan" <kys@microsoft.com>, will@kernel.org, Wei Liu <wei.liu@kernel.org>, Stephen Hemminger <sthemmin@microsoft.com>, arnd@arndb.de, corbet@lwn.net, paulmck@kernel.org, fabiomirmar@gmail.com, x86@kernel.org, Dexuan Cui <decui@microsoft.com>, mingo@redhat.com, stern@rowland.harvard.edu, dyoung@redhat.com, vgoyal@redhat.com, Andrea Parri <parri.andrea@gmail.com>, alejandro.j.jimenez@oracle.com, Tianyu Lan <Tianyu.Lan@microsoft.com>, keescook@chromium.org, john.ogness@linutronix.de, Haiyang Zhang <haiyangz@microsoft.com>, rostedt@goodmis.org, bp@alien8.de, luto@kernel.org, hidehiro.kawai.ez@hitachi.com, tglx@linutronix.de, andriy.shevchenko@linux.intel.com, jgross@suse.com, gregkh@linuxfoundation.org, kernel@gpiccoli.net, linux-kernel@vger.kernel.org, senozhatsky@chromium.org, d.hatayama@jp.fujitsu.com, mhiramat@kernel.org, kernel-dev@igalia.com, netdev@vger.kernel.org, vkuznets@redhat.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

The Hyper-V framebuffer code registers a panic notifier in order
to try updating its fbdev if the kernel crashed. The notifier
callback is straightforward, but it calls the vmbus_sendpacket()
routine eventually, and such function takes a spinlock for the
ring buffer operations.

Panic path runs in atomic context, with local interrupts and
preemption disabled, and all secondary CPUs shutdown. That said,
taking a spinlock might cause a lockup if a secondary CPU was
disabled with such lock taken. Fix it here by checking if the
ring buffer spinlock is busy on Hyper-V framebuffer panic notifier;
if so, bail-out avoiding the potential lockup scenario.

Cc: Andrea Parri (Microsoft) <parri.andrea@gmail.com>
Cc: Dexuan Cui <decui@microsoft.com>
Cc: Haiyang Zhang <haiyangz@microsoft.com>
Cc: "K. Y. Srinivasan" <kys@microsoft.com>
Cc: Michael Kelley <mikelley@microsoft.com>
Cc: Stephen Hemminger <sthemmin@microsoft.com>
Cc: Tianyu Lan <Tianyu.Lan@microsoft.com>
Cc: Wei Liu <wei.liu@kernel.org>
Tested-by: Fabio A M Martins <fabiomirmar@gmail.com>
Signed-off-by: Guilherme G. Piccoli <gpiccoli@igalia.com>

---

V2:
- new patch, based on the discussion in [0].
[0] https://lore.kernel.org/lkml/2787b476-6366-1c83-db80-0393da417497@igalia.com/

 drivers/hv/ring_buffer.c        | 16 ++++++++++++++++
 drivers/video/fbdev/hyperv_fb.c |  8 +++++++-
 include/linux/hyperv.h          |  2 ++
 3 files changed, 25 insertions(+), 1 deletion(-)

diff --git a/drivers/hv/ring_buffer.c b/drivers/hv/ring_buffer.c
index 59a4aa86d1f3..9ceb3a7e8d19 100644
--- a/drivers/hv/ring_buffer.c
+++ b/drivers/hv/ring_buffer.c
@@ -280,6 +280,22 @@ void hv_ringbuffer_cleanup(struct hv_ring_buffer_info *ring_info)
 	ring_info->pkt_buffer_size = 0;
 }
 
+/*
+ * Check if the ring buffer spinlock is available to take or not; used on
+ * atomic contexts, like panic path (see the Hyper-V framebuffer driver).
+ */
+
+bool hv_ringbuffer_spinlock_busy(struct vmbus_channel *channel)
+{
+	struct hv_ring_buffer_info *rinfo = &channel->outbound;
+
+	if (spin_is_locked(&rinfo->ring_lock))
+		return true;
+
+	return false;
+}
+EXPORT_SYMBOL_GPL(hv_ringbuffer_spinlock_busy);
+
 /* Write to the ring buffer. */
 int hv_ringbuffer_write(struct vmbus_channel *channel,
 			const struct kvec *kv_list, u32 kv_count,
diff --git a/drivers/video/fbdev/hyperv_fb.c b/drivers/video/fbdev/hyperv_fb.c
index 886c564787f1..e1b65a01fb96 100644
--- a/drivers/video/fbdev/hyperv_fb.c
+++ b/drivers/video/fbdev/hyperv_fb.c
@@ -783,12 +783,18 @@ static void hvfb_ondemand_refresh_throttle(struct hvfb_par *par,
 static int hvfb_on_panic(struct notifier_block *nb,
 			 unsigned long e, void *p)
 {
+	struct hv_device *hdev;
 	struct hvfb_par *par;
 	struct fb_info *info;
 
 	par = container_of(nb, struct hvfb_par, hvfb_panic_nb);
-	par->synchronous_fb = true;
 	info = par->info;
+	hdev = device_to_hv_device(info->device);
+
+	if (hv_ringbuffer_spinlock_busy(hdev->channel))
+		return NOTIFY_DONE;
+
+	par->synchronous_fb = true;
 	if (par->need_docopy)
 		hvfb_docopy(par, 0, dio_fb_size);
 	synthvid_update(info, 0, 0, INT_MAX, INT_MAX);
diff --git a/include/linux/hyperv.h b/include/linux/hyperv.h
index 3b42264333ef..646f1da9f27e 100644
--- a/include/linux/hyperv.h
+++ b/include/linux/hyperv.h
@@ -1341,6 +1341,8 @@ struct hv_ring_buffer_debug_info {
 int hv_ringbuffer_get_debuginfo(struct hv_ring_buffer_info *ring_info,
 				struct hv_ring_buffer_debug_info *debug_info);
 
+bool hv_ringbuffer_spinlock_busy(struct vmbus_channel *channel);
+
 /* Vmbus interface */
 #define vmbus_driver_register(driver)	\
 	__vmbus_driver_register(driver, THIS_MODULE, KBUILD_MODNAME)
-- 
2.37.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
