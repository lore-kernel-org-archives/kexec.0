Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]
 helo=us-smtp-1.mimecast.com)
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jWCEe-0006lx-SX
 for kexec@lists.infradead.org; Wed, 06 May 2020 05:04:46 +0000
Received: by mail-qv1-f71.google.com with SMTP id m20so1020380qvy.13
 for <kexec@lists.infradead.org>; Tue, 05 May 2020 22:04:40 -0700 (PDT)
MIME-Version: 1.0
References: <1588705481-18385-1-git-send-email-bhsharma@redhat.com>
 <1588705481-18385-2-git-send-email-bhsharma@redhat.com>
 <20200505.142439.1075452616982863931.davem@davemloft.net>
In-Reply-To: <20200505.142439.1075452616982863931.davem@davemloft.net>
From: Bhupesh Sharma <bhsharma@redhat.com>
Date: Wed, 6 May 2020 10:34:28 +0530
Message-ID: <CACi5LpP+47EEO4YS6TCPPA4-xeu6phXV2uz=8bfWdfggwC73Kg@mail.gmail.com>
Subject: Re: [PATCH 1/2] net: qed*: Reduce RX and TX default ring count when
 running inside kdump kernel
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
To: David Miller <davem@davemloft.net>
Cc: aelior@marvell.com, manishc@marvell.com, netdev@vger.kernel.org, kexec mailing list <kexec@lists.infradead.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, GR-everest-linux-l2@marvell.com, Bhupesh SHARMA <bhupesh.linux@gmail.com>

Hi David,

On Wed, May 6, 2020 at 2:54 AM David Miller <davem@davemloft.net> wrote:
>
> From: Bhupesh Sharma <bhsharma@redhat.com>
> Date: Wed,  6 May 2020 00:34:40 +0530
>
> > -#define NUM_RX_BDS_DEF               ((u16)BIT(10) - 1)
> > +#define NUM_RX_BDS_DEF               ((is_kdump_kernel()) ? ((u16)BIT(6) - 1) : ((u16)BIT(10) - 1))
>
> These parenthesis are very excessive and unnecessary.  At the
> very least remove the parenthesis around is_kdump_kernel().

Thanks a lot for the review.
Sure, will fix this in the v2.

Regards,
Bhupesh


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
