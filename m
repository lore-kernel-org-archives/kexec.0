Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5814BCD98E3
	for <kexec@archiver.kernel.org>; Tue, 16 Jun 2026 16:10:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=oYzDz6Op63i1b1Es07mE9ik1AD2u9zxTqg55lTEbStE=; b=XKPZqHsFZAN0qQOZElDEqDhmnx
	cVnQsoDEmnJZOQ3Puoja/6d+tlhPCQ8TH3TqC+M0SZJZUKBtvSVP8DdtqJrUGKekTNqJcdruKCFCh
	oga0mC73N+cElsddHluoYlLbuslTGRIpBvgU78ZmjCyBRZzlR5KfL3JGPFC8FyuCjMu4QTHLjCmYr
	v38JRy43KzeEm4bXLQXzAHPfABLwHP0dgNO/VkugJgm8i2XHRTKnKbvT6YfrpeQ2VL0DTl/b2k6qI
	FshcvB/rdeIKlZOQhtH5OvAZNHRmkkLpJgZ+67TNZhTRUU4QaoDKvZ1xix57Kshwqoz3LdZ0+mYkv
	Ss9g8gjg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wZWNA-0000000G5D2-1LER;
	Tue, 16 Jun 2026 16:10:44 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wZWN7-0000000G5CD-0Fy6
	for kexec@lists.infradead.org;
	Tue, 16 Jun 2026 16:10:42 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1781626240;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oYzDz6Op63i1b1Es07mE9ik1AD2u9zxTqg55lTEbStE=;
	b=GeOOJrs5itR8frZ4PMLlOxSdv2lGquBs8PP9yvf7NTszKgz2+3IIfjIIc8xQFXK18iAJXG
	Opanv/H0pgij3ilgwA+H2waH2q9oPJwQ5h76nFLulKXf74OPUAbuTXWwoVMQRdd+mDjnwf
	7qMAxk7wyf8oV4EP7JIVJlq+Ng8Fc3s=
Received: from mail-vk1-f200.google.com (mail-vk1-f200.google.com
 [209.85.221.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-581-kbUeODeCOJuKqxbcbyur0Q-1; Tue, 16 Jun 2026 12:10:37 -0400
X-MC-Unique: kbUeODeCOJuKqxbcbyur0Q-1
X-Mimecast-MFC-AGG-ID: kbUeODeCOJuKqxbcbyur0Q_1781626236
Received: by mail-vk1-f200.google.com with SMTP id 71dfb90a1353d-59d595bfd94so2470151e0c.3
        for <kexec@lists.infradead.org>; Tue, 16 Jun 2026 09:10:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781626236; x=1782231036;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=oYzDz6Op63i1b1Es07mE9ik1AD2u9zxTqg55lTEbStE=;
        b=C8nlDgwo0mYUT//AoTDz3NiTTMc2pK2HMyppy9rmi9lAE+XbPwKya2xVLHhEvWzdGH
         mb/bTTZ6XAcjy/CckY5UwrUp4vgYrT0wNQsJODwWYx20ofGWn8KAsEzGpoiSlZmKOVHm
         sZKB7/okLGgt1uX2VGpTqxdvlIfgWUXkDNjb9CCx0aQGNFuR+BxWy+I2OjAJDy8TA6zj
         4PVDzAxDOFL2qUSds2ak4AwXbmcR0nJqOnP0xOfZEzHNqOW+6yuCDQMwFYZJzUhlpPeD
         GoMcUR7JOJJzvL3K/e5c+WJvldO6+DeSl4DQ9VROqwyS9yfxGSoZsKRf5xY20YpsZL54
         zeig==
X-Forwarded-Encrypted: i=1; AFNElJ/DMQBLr0U/xZ9kOtPfuR3uVIDLaPsIQJlqzT1Zqg+YnPrdIrJEGQvbWnfJfvgxopAraMVfgw==@lists.infradead.org
X-Gm-Message-State: AOJu0YzwRB7k95WM3U4AAuqPWJrgR4VL2Q20LiiAzdsfd3GZQtvaA28w
	PNDisZlFFT1dpW4sEjbTJAy4WDUwSSUsDaGfsVfxLSesn1p78rODyF4rE8V29iETI12a1HDpchJ
	pt7W0V0mtqrNa16WlylY2uCwjOj58NUIFFH3QIPfezR506VJpGScjt8PpiYV65n3q8VAtbnnW3G
	3sVScmLuFpV/jbSk4HPfLRkSk5+o4DC8V0d/GF
X-Gm-Gg: Acq92OG39euqd0l7wv7WLwfFwY5BhIMlHuDgQLHMDRHwcoT9jJrs5gHdsbcpnS9j72e
	JrsT4K27mlq+93+0wJ59JmSHdKX3wpzv6Fn6FNVMy6MkEgz8NL1EYhlyLA+riukBpaHloiPBvvr
	76WBnDHDfzqV38TnNQiy8D9p4Gf4KwK3GTLV+Cl1kF5Cix06ubA02pC3/YTDh9sjxbuKTBK9Cv8
	WJnAHYPHrOAANTGatCUngIcHwVpvf46Tu5ed0O07fbMT0baWlv4FpEil0Nt
X-Received: by 2002:a05:6122:2886:b0:59e:b127:fc6f with SMTP id 71dfb90a1353d-5bbbe46f083mr136452e0c.2.1781626235797;
        Tue, 16 Jun 2026 09:10:35 -0700 (PDT)
X-Received: by 2002:a05:6122:2886:b0:59e:b127:fc6f with SMTP id
 71dfb90a1353d-5bbbe46f083mr136421e0c.2.1781626235332; Tue, 16 Jun 2026
 09:10:35 -0700 (PDT)
MIME-Version: 1.0
References: <20260616152219.6268-1-djeffery@redhat.com> <20260616152219.6268-4-djeffery@redhat.com>
In-Reply-To: <20260616152219.6268-4-djeffery@redhat.com>
From: David Jeffery <djeffery@redhat.com>
Date: Tue, 16 Jun 2026 12:10:23 -0400
X-Gm-Features: AVVi8CcAVaHcV51QjovJA8RG5VnZNDjVsIyhw2UF22IaX5vguXNcx3MAVGE5xto
Message-ID: <CA+-xHTEbjiUXC0JHoSsyzNRx4CC8QxwQi92op0GxVHZTVskeiQ@mail.gmail.com>
Subject: Re: [PATCH 3/5] driver core: async device shutdown infrastructure
To: driver-core@lists.linux.dev, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Danilo Krummrich <dakr@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, 
	linux-scsi@vger.kernel.org, Tarun Sahu <tarunsahu@google.com>, 
	Pasha Tatashin <tatashin@google.com>, =?UTF-8?B?TWljaGHFgiBDxYJhcGnFhHNraQ==?= <mclapinski@google.com>, 
	Jordan Richards <jordanrichards@google.com>, Ewan Milne <emilne@redhat.com>, 
	John Meneghini <jmeneghi@redhat.com>, "Lombardi, Maurizio" <mlombard@redhat.com>, 
	Stuart Hayes <stuart.w.hayes@gmail.com>, Laurence Oberman <loberman@redhat.com>, 
	Bart Van Assche <bvanassche@acm.org>, Bjorn Helgaas <helgaas@kernel.org>, 
	"Martin K . Petersen" <martin.petersen@oracle.com>, John Garry <john.g.garry@oracle.com>, 
	kexec@lists.infradead.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: Yvml3ELItmouIvkloOYKCzPewKp4XepemgMZyf99bnE_1781626236
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260616_091041_178896_2A221354 
X-CRM114-Status: GOOD (  31.93  )
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
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

On Tue, Jun 16, 2026 at 11:23=E2=80=AFAM David Jeffery <djeffery@redhat.com=
> wrote:
>
> Patterned after async suspend, allow devices to mark themselves as wantin=
g
> to perform async shutdown. Devices using async shutdown wait only for the=
ir
> dependencies to shutdown before executing their shutdown routine.
>
> Sync shutdown devices are shut down one at a time and will only wait for =
an
> async shutdown device if the async device is a dependency.
>
> Enabled by default, async shutdown can be explicitly enabled or disabled
> by using the kernel parameter "core.async_shutdown=3D<bool>"
>
> Signed-off-by: David Jeffery <djeffery@redhat.com>
> Signed-off-by: Stuart Hayes <stuart.w.hayes@gmail.com>
> Tested-by: Laurence Oberman <loberman@redhat.com>
> ---
>  .../admin-guide/kernel-parameters.txt         |  10 ++
>  drivers/base/base.h                           |   2 +
>  drivers/base/core.c                           | 127 +++++++++++++++++-
>  include/linux/device.h                        |   2 +
>  4 files changed, 140 insertions(+), 1 deletion(-)
>
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentat=
ion/admin-guide/kernel-parameters.txt
> index b5a51a36a048..dd912f47ace4 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -1019,6 +1019,16 @@ Kernel parameters
>                         seconds. A value of 0 disables the blank timer.
>                         Defaults to 0.
>
> +       core.async_shutdown=3D
> +                       [KNL]
> +                       Format: <bool>
> +                       Enable or disable asynchronous shutdown support. =
When
> +                       enabled, on system shutdown unrelated devices fla=
gged
> +                       as async shutdown compatible may be shut down in
> +                       parallel and asynchronously. When disabled, devic=
e
> +                       shutdown is performed in a serially and synchrono=
usly.
> +                       Enabled by default.
> +
>         coredump_filter=3D
>                         [KNL] Change the default value for
>                         /proc/<pid>/coredump_filter.
> diff --git a/drivers/base/base.h b/drivers/base/base.h
> index a5b7abc10ff0..40dbf588a5d6 100644
> --- a/drivers/base/base.h
> +++ b/drivers/base/base.h
> @@ -103,6 +103,7 @@ struct driver_private {
>   *                        dev_err_probe() for later retrieval via debugf=
s
>   * @device: pointer back to the struct device that this structure is
>   *         associated with.
> + * @complete: completion for device shutdown ordering
>   * @dead: This device is currently either in the process of or has been
>   *       removed from the system. Any asynchronous events scheduled for =
this
>   *       device should exit without taking any action.
> @@ -119,6 +120,7 @@ struct device_private {
>         const struct device_driver *async_driver;
>         char *deferred_probe_reason;
>         struct device *device;
> +       struct completion complete;
>         u8 dead:1;
>  };
>  #define to_device_private_parent(obj)  \
> diff --git a/drivers/base/core.c b/drivers/base/core.c
> index 3b3d983b1747..751fe2e13b3a 100644
> --- a/drivers/base/core.c
> +++ b/drivers/base/core.c
> @@ -9,6 +9,7 @@
>   */
>
>  #include <linux/acpi.h>
> +#include <linux/async.h>
>  #include <linux/blkdev.h>
>  #include <linux/cleanup.h>
>  #include <linux/cpufreq.h>
> @@ -37,6 +38,10 @@
>  #include "physical_location.h"
>  #include "power/power.h"
>
> +static bool async_shutdown =3D true;
> +module_param(async_shutdown, bool, 0644);
> +MODULE_PARM_DESC(async_shutdown, "Enable asynchronous device shutdown su=
pport");
> +
>  /* Device links support. */
>  static LIST_HEAD(deferred_sync);
>  static unsigned int defer_sync_state_count =3D 1;
> @@ -3606,6 +3611,7 @@ static int device_private_init(struct device *dev)
>         klist_init(&dev->p->klist_children, klist_children_get,
>                    klist_children_put);
>         INIT_LIST_HEAD(&dev->p->deferred_probe);
> +       init_completion(&dev->p->complete);
>         return 0;
>  }
>
> @@ -3895,6 +3901,7 @@ bool kill_device(struct device *dev)
>         if (dev->p->dead)
>                 return false;
>         dev->p->dead =3D true;
> +       complete_all(&dev->p->complete);
>         return true;
>  }
>  EXPORT_SYMBOL_GPL(kill_device);
> @@ -4865,6 +4872,37 @@ int device_change_owner(struct device *dev, kuid_t=
 kuid, kgid_t kgid)
>         return error;
>  }
>
> +static bool wants_async_shutdown(struct device *dev)
> +{
> +       return async_shutdown && dev_async_shutdown(dev);
> +}
> +
> +static int wait_for_device_shutdown(struct device *dev, void *data)
> +{
> +       bool async =3D *(bool *)data;
> +
> +       if (async || wants_async_shutdown(dev))
> +               wait_for_completion(&dev->p->complete);
> +
> +       return 0;
> +}
> +
> +static void wait_for_shutdown_dependencies(struct device *dev, bool asyn=
c)
> +{
> +       struct device_link *link;
> +       int idx;
> +
> +       device_for_each_child(dev, &async, wait_for_device_shutdown);
> +
> +       idx =3D device_links_read_lock();
> +
> +       dev_for_each_link_to_consumer(link, dev)
> +               if (!device_link_flag_is_sync_state_only(link->flags))
> +                       wait_for_device_shutdown(link->consumer, &async);
> +
> +       device_links_read_unlock(idx);
> +}
> +
>  static void __shutdown_one_device(struct device *dev)
>  {
>         if (dev->p->dead)
> @@ -4888,6 +4926,8 @@ static void __shutdown_one_device(struct device *de=
v)
>                         dev_info(dev, "shutdown\n");
>                 dev->driver->shutdown(dev);
>         }
> +
> +       complete_all(&dev->p->complete);
>  }
>
>  static void shutdown_one_device(struct device *dev)
> @@ -4917,6 +4957,80 @@ static void shutdown_one_device(struct device *dev=
)
>         put_device(dev);
>  }
>
> +static void async_shutdown_handler(void *data, async_cookie_t cookie)
> +{
> +       struct device *dev =3D data;
> +
> +       wait_for_shutdown_dependencies(dev, true);
> +       shutdown_one_device(dev);
> +}
> +
> +static bool shutdown_device_async(struct device *dev)
> +{
> +       if (async_schedule_dev_nocall(async_shutdown_handler, dev))
> +               return true;
> +
> +       dev_clear_async_shutdown(dev);
> +       return false;
> +}
> +
> +
> +static void start_async_shutdown_devices(void)
> +{
> +       struct device *dev, *next, *ndev, *needs_put =3D NULL;
> +       bool clear_async =3D false;
> +
> +       if (!async_shutdown)
> +               return;
> +
> +       spin_lock(&devices_kset->list_lock);
> +restart:
> +       list_for_each_entry_safe_reverse(dev, next, &devices_kset->list,
> +                                        kobj.entry) {
> +               if (wants_async_shutdown(dev)) {
> +                       if (clear_async) {
> +                               dev_clear_async_shutdown(dev);
> +                               continue;
> +                       }
> +                       get_device(dev);
> +
> +                       if (!list_entry_is_head(next, &devices_kset->list=
,
> +                                               kobj.entry))
> +                               ndev =3D get_device(next);
> +                       else
> +                               ndev =3D NULL;
> +                       spin_unlock(&devices_kset->list_lock);
> +
> +                       if (shutdown_device_async(dev)) {
> +                               list_del_init(&dev->kobj.entry);


Sashiko detected a locking error here. The lock rework made
list_del_init occur while not holding the spinlock, which is a
potential list corruption issue. This will be corrected in the next
iteration.

David Jeffery


