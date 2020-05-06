Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]
 helo=us-smtp-1.mimecast.com)
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jWEF8-0003gG-4W
 for kexec@lists.infradead.org; Wed, 06 May 2020 07:13:23 +0000
Received: by mail-qt1-f197.google.com with SMTP id g23so1734185qto.0
 for <kexec@lists.infradead.org>; Wed, 06 May 2020 00:13:16 -0700 (PDT)
MIME-Version: 1.0
References: <1588705481-18385-1-git-send-email-bhsharma@redhat.com>
 <1588705481-18385-2-git-send-email-bhsharma@redhat.com>
 <5ddc169b-f837-e478-43d9-4d6cf587aa05@marvell.com>
In-Reply-To: <5ddc169b-f837-e478-43d9-4d6cf587aa05@marvell.com>
From: Bhupesh Sharma <bhsharma@redhat.com>
Date: Wed, 6 May 2020 12:43:03 +0530
Message-ID: <CACi5LpNCHipB-bU52JcWBj6bPhW5ZqfG+J7QPq-m5-xf2mqdSQ@mail.gmail.com>
Subject: Re: [EXT] [PATCH 1/2] net: qed*: Reduce RX and TX default ring count
 when running inside kdump kernel
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
To: Igor Russkikh <irusskikh@marvell.com>
Cc: Ariel Elior <aelior@marvell.com>, Alok Prasad <palok@marvell.com>, Manish Chopra <manishc@marvell.com>, netdev@vger.kernel.org, kexec mailing list <kexec@lists.infradead.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, GR-everest-linux-l2 <GR-everest-linux-l2@marvell.com>, Bhupesh SHARMA <bhupesh.linux@gmail.com>, "David S . Miller" <davem@davemloft.net>

Hello Igor,

On Wed, May 6, 2020 at 12:21 PM Igor Russkikh <irusskikh@marvell.com> wrote:
>
>
>
> >  #include <linux/compiler.h>
> > +#include <linux/crash_dump.h>
> >  #include <linux/version.h>
> >  #include <linux/workqueue.h>
> >  #include <linux/netdevice.h>
> > @@ -574,13 +575,13 @@ int qede_add_tc_flower_fltr(struct qede_dev *edev,
> > __be16 proto,
> >  #define RX_RING_SIZE         ((u16)BIT(RX_RING_SIZE_POW))
> >  #define NUM_RX_BDS_MAX               (RX_RING_SIZE - 1)
> >  #define NUM_RX_BDS_MIN               128
> > -#define NUM_RX_BDS_DEF               ((u16)BIT(10) - 1)
> > +#define NUM_RX_BDS_DEF               ((is_kdump_kernel()) ? ((u16)BIT(6) - 1) :
> > ((u16)BIT(10) - 1))
> >
> >  #define TX_RING_SIZE_POW     13
> >  #define TX_RING_SIZE         ((u16)BIT(TX_RING_SIZE_POW))
> >  #define NUM_TX_BDS_MAX               (TX_RING_SIZE - 1)
> >  #define NUM_TX_BDS_MIN               128
> > -#define NUM_TX_BDS_DEF               NUM_TX_BDS_MAX
> > +#define NUM_TX_BDS_DEF               ((is_kdump_kernel()) ? ((u16)BIT(6) - 1) :
> > NUM_TX_BDS_MAX)
> >
>
> Hi Bhupesh,
>
> Thanks for looking into this. We are also analyzing how to reduce qed* memory
> usage even more.
>
> Patch is good, but may I suggest not to introduce conditional logic into the
> defines but instead just add two new defines like NUM_[RT]X_BDS_MIN and check
> for is_kdump_kernel() in the code explicitly?
>
> if (is_kdump_kernel()) {
>         edev->q_num_rx_buffers = NUM_RX_BDS_MIN;
>         edev->q_num_tx_buffers = NUM_TX_BDS_MIN;
> } else {
>         edev->q_num_rx_buffers = NUM_RX_BDS_DEF;
>         edev->q_num_tx_buffers = NUM_TX_BDS_DEF;
> }
>
> This may make configuration logic more explicit. If future we may want adding
> more specific configs under this `if`.

Thanks for the review comments.
The suggestions seem fine to me. I will incorporate them in v2.

Regards,
Bhupesh


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
