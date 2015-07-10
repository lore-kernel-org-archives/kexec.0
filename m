Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from e06smtp13.uk.ibm.com ([195.75.94.109])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1ZDUcn-0005r2-8J
 for kexec@lists.infradead.org; Fri, 10 Jul 2015 09:29:41 +0000
Received: from /spool/local
 by e06smtp13.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <kexec@lists.infradead.org> from <holzheu@linux.vnet.ibm.com>;
 Fri, 10 Jul 2015 10:29:19 +0100
Received: from b06cxnps4075.portsmouth.uk.ibm.com
 (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
 by d06dlp01.portsmouth.uk.ibm.com (Postfix) with ESMTP id 62C7B17D8063
 for <kexec@lists.infradead.org>; Fri, 10 Jul 2015 10:30:32 +0100 (BST)
Received: from d06av02.portsmouth.uk.ibm.com (d06av02.portsmouth.uk.ibm.com
 [9.149.37.228])
 by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t6A9TFwx26280074
 for <kexec@lists.infradead.org>; Fri, 10 Jul 2015 09:29:15 GMT
Received: from d06av02.portsmouth.uk.ibm.com (localhost [127.0.0.1])
 by d06av02.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t6A9TExP028151
 for <kexec@lists.infradead.org>; Fri, 10 Jul 2015 03:29:15 -0600
Date: Fri, 10 Jul 2015 11:29:13 +0200
From: Michael Holzheu <holzheu@linux.vnet.ibm.com>
Subject: Re: [PATCH v4] kexec: Make a pair of map and unmap reserved pages
 when kdump fails to start
Message-ID: <20150710112913.3d6853cb@holzheu>
In-Reply-To: <20150710111406.279dba14@holzheu>
References: <1436505137-4364-1-git-send-email-mnfhuang@gmail.com>
 <20150710105413.04e1db00@holzheu>
 <20150710090322.GA5138@dhcp-128-21.nay.redhat.com>
 <20150710111406.279dba14@holzheu>
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
To: Michael Holzheu <holzheu@linux.vnet.ibm.com>
Cc: linux-s390@vger.kernel.org, kexec@lists.infradead.org, heiko.carstens@de.ibm.com, linux-kernel@vger.kernel.org, Minfei Huang <mnfhuang@gmail.com>, schwidefsky@de.ibm.com, linux390@de.ibm.com, vgoyal@redhat.com, ebiederm@xmission.com

On Fri, 10 Jul 2015 11:14:06 +0200
Michael Holzheu <holzheu@linux.vnet.ibm.com> wrote:

> On Fri, 10 Jul 2015 17:03:22 +0800
> Minfei Huang <mnfhuang@gmail.com> wrote:

[snip]

> +static int __kexec_load(unsigned long entry, unsigned long nr_segments,
> +			struct kexec_segment __user *segments,
> +			unsigned long flags)
> +{
> +	struct kimage **dest_image, *image;
> +	unsigned long i;
> +	int result;
> +
> +	if (flags & KEXEC_ON_CRASH)
> +		dest_image = &kexec_crash_image;
> +	else
> +		dest_image = &kexec_image;
> +
> +	if (nr_segments == 0) {
> +		/* Uninstall image */
> +		kfree(xchg(dest_image, NULL));

Sorry, too fast today...
Should be of course not kfree, but:

kimage_free(dest_image, NULL));

Michael


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
