Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from fgwmail5.fujitsu.co.jp ([192.51.44.35])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1VItNI-0004Ej-1z
 for kexec@lists.infradead.org; Mon, 09 Sep 2013 04:46:57 +0000
Received: from m2.gw.fujitsu.co.jp (unknown [10.0.50.72])
 by fgwmail5.fujitsu.co.jp (Postfix) with ESMTP id 1F0093EE1CA
 for <kexec@lists.infradead.org>; Mon,  9 Sep 2013 13:46:31 +0900 (JST)
Received: from smail (m2 [127.0.0.1])
 by outgoing.m2.gw.fujitsu.co.jp (Postfix) with ESMTP id 114E145DE52
 for <kexec@lists.infradead.org>; Mon,  9 Sep 2013 13:46:31 +0900 (JST)
Received: from s2.gw.fujitsu.co.jp (s2.gw.fujitsu.co.jp [10.0.50.92])
 by m2.gw.fujitsu.co.jp (Postfix) with ESMTP id EFEC445DE4E
 for <kexec@lists.infradead.org>; Mon,  9 Sep 2013 13:46:30 +0900 (JST)
Received: from s2.gw.fujitsu.co.jp (localhost.localdomain [127.0.0.1])
 by s2.gw.fujitsu.co.jp (Postfix) with ESMTP id E4D9A1DB803C
 for <kexec@lists.infradead.org>; Mon,  9 Sep 2013 13:46:30 +0900 (JST)
Received: from m1000.s.css.fujitsu.com (m1000.s.css.fujitsu.com
 [10.240.81.136])
 by s2.gw.fujitsu.co.jp (Postfix) with ESMTP id 999411DB803A
 for <kexec@lists.infradead.org>; Mon,  9 Sep 2013 13:46:30 +0900 (JST)
Message-ID: <522D5299.9020809@jp.fujitsu.com>
Date: Mon, 09 Sep 2013 13:46:17 +0900
From: Takao Indoh <indou.takao@jp.fujitsu.com>
MIME-Version: 1.0
Subject: Re: [PATCH] intel-iommu: Quiesce devices before disabling IOMMU
References: <1377069354-5056-1-git-send-email-indou.takao@jp.fujitsu.com>
 <20130908114752.GA24572@dhcp-16-252.nay.redhat.com>
 <522D4E8A.8010507@jp.fujitsu.com>
In-Reply-To: <522D4E8A.8010507@jp.fujitsu.com>
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
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: bhe@redhat.com
Cc: joro@8bytes.org, kexec@lists.infradead.org, iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org, alex.williamson@redhat.com, dwmw2@infradead.org

(2013/09/09 13:28), Takao Indoh wrote:
>> BTW, what's the status of Alex's PCI patchset which this patch depends
>> on?
> 
> It is merged to Bjorn's tree, will be in v3.12.

This was wrong. Alex's patchset is already in Linus tree, v3.11.

Thanks,
Takao Indoh



_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
