Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from shards.monkeyblade.net ([2620:137:e000::1:9])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jW53X-0001Ed-Gx
 for kexec@lists.infradead.org; Tue, 05 May 2020 21:24:48 +0000
Date: Tue, 05 May 2020 14:24:39 -0700 (PDT)
Message-Id: <20200505.142439.1075452616982863931.davem@davemloft.net>
Subject: Re: [PATCH 1/2] net: qed*: Reduce RX and TX default ring count
 when running inside kdump kernel
From: David Miller <davem@davemloft.net>
In-Reply-To: <1588705481-18385-2-git-send-email-bhsharma@redhat.com>
References: <1588705481-18385-1-git-send-email-bhsharma@redhat.com>
 <1588705481-18385-2-git-send-email-bhsharma@redhat.com>
Mime-Version: 1.0
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
To: bhsharma@redhat.com
Cc: aelior@marvell.com, manishc@marvell.com, netdev@vger.kernel.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, GR-everest-linux-l2@marvell.com, bhupesh.linux@gmail.com

From: Bhupesh Sharma <bhsharma@redhat.com>
Date: Wed,  6 May 2020 00:34:40 +0530

> -#define NUM_RX_BDS_DEF		((u16)BIT(10) - 1)
> +#define NUM_RX_BDS_DEF		((is_kdump_kernel()) ? ((u16)BIT(6) - 1) : ((u16)BIT(10) - 1))

These parenthesis are very excessive and unnecessary.  At the
very least remove the parenthesis around is_kdump_kernel().

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
