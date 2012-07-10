Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from fgwmail5.fujitsu.co.jp ([192.51.44.35])
 by merlin.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1SoPGC-0007En-7w
 for kexec@lists.infradead.org; Tue, 10 Jul 2012 01:29:06 +0000
Received: from m4.gw.fujitsu.co.jp (unknown [10.0.50.74])
 by fgwmail5.fujitsu.co.jp (Postfix) with ESMTP id B6C913EE0AE
 for <kexec@lists.infradead.org>; Tue, 10 Jul 2012 10:28:46 +0900 (JST)
Received: from smail (m4 [127.0.0.1])
 by outgoing.m4.gw.fujitsu.co.jp (Postfix) with ESMTP id 9FDD545DE53
 for <kexec@lists.infradead.org>; Tue, 10 Jul 2012 10:28:46 +0900 (JST)
Received: from s4.gw.fujitsu.co.jp (s4.gw.fujitsu.co.jp [10.0.50.94])
 by m4.gw.fujitsu.co.jp (Postfix) with ESMTP id 8AE9945DE4F
 for <kexec@lists.infradead.org>; Tue, 10 Jul 2012 10:28:46 +0900 (JST)
Received: from s4.gw.fujitsu.co.jp (localhost.localdomain [127.0.0.1])
 by s4.gw.fujitsu.co.jp (Postfix) with ESMTP id 7C52D1DB8040
 for <kexec@lists.infradead.org>; Tue, 10 Jul 2012 10:28:46 +0900 (JST)
Received: from m022.s.css.fujitsu.com (m022.s.css.fujitsu.com [10.0.81.62])
 by s4.gw.fujitsu.co.jp (Postfix) with ESMTP id 339F61DB8037
 for <kexec@lists.infradead.org>; Tue, 10 Jul 2012 10:28:46 +0900 (JST)
Date: Tue, 10 Jul 2012 10:28:32 +0900 (JST)
Message-Id: <20120710.102832.104908620.d.hatayama@jp.fujitsu.com>
Subject: Re: [PATCH v4 2/3] KVM-INTEL: Add new module vmcsinfo-intel to
 fill VMCSINFO
From: HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>
In-Reply-To: <4FF4155F.6070508@cn.fujitsu.com>
References: <4FF413D2.4030006@cn.fujitsu.com> <4FF4155F.6070508@cn.fujitsu.com>
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
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: zhangyanfei@cn.fujitsu.com
Cc: dzickus@redhat.com, luto@mit.edu, kvm@vger.kernel.org, joerg.roedel@amd.com, mtosatti@redhat.com, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, paul.gortmaker@windriver.com, ludwig.nussel@suse.de, avi@redhat.com, gregkh@linuxfoundation.org, ebiederm@xmission.com

From: Yanfei Zhang <zhangyanfei@cn.fujitsu.com>
Subject: [PATCH v4 2/3] KVM-INTEL: Add new module vmcsinfo-intel to fill VMCSINFO
Date: Wed, 4 Jul 2012 18:05:19 +0800

> 
> Besides, this patch also exports vmcs revision identifier via
> /sys/devices/system/cpu/vmcs_id and offsets of fields via
> /sys/devices/system/cpu/vmcs/.

I think /sys/devices/system/cpu/vmcs/id is more natural, which also
belongs to vmcs.

<cut>
> +/*
> + * vmcs field offsets.
> + */
> +static struct vmcsinfo {
> +	u32 vmcs_revision_id;
> +	u16 vmcs_field_to_offset_table[HOST_RIP + 1];
> +} vmcsinfo;

This is what I said previously. HOST_RIP is 0x00006c16 => 27670. This
means sizeof (struct vmcsinfo) => 55346 bytes == 54 kbytes. But
actually exported fields are only 153, so 4 + 2 * 153 => 310 bytes are
enough.

How about getting the number of attributes from vmcs_attrs array? I
guess this is exactly the number of vmcs fields exported; here 153.

Thanks.
HATAYAMA, Daisuke

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
