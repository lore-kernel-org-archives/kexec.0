Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1ZrLuU-0004uk-GZ
 for kexec@lists.infradead.org; Wed, 28 Oct 2015 08:16:42 +0000
Received: from int-mx14.intmail.prod.int.phx2.redhat.com
 (int-mx14.intmail.prod.int.phx2.redhat.com [10.5.11.27])
 by mx1.redhat.com (Postfix) with ESMTPS id 3CA1DC0B5918
 for <kexec@lists.infradead.org>; Wed, 28 Oct 2015 08:16:22 +0000 (UTC)
Date: Wed, 28 Oct 2015 16:16:15 +0800
From: Dave Young <dyoung@redhat.com>
Subject: Re: [PATCH v2] vmcore-dmesg: Collect full dmesg regardless of
 logged_chars
Message-ID: <20151028081615.GF30645@dhcp-128-73.nay.redhat.com>
References: <1446018641-11404-1-git-send-email-dliu@redhat.com>
 <20151028081106.GE30645@dhcp-128-73.nay.redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20151028081106.GE30645@dhcp-128-73.nay.redhat.com>
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
To: Dangyi Liu <dliu@redhat.com>
Cc: kexec@lists.infradead.org

> > +	 * To collect full dmesg including the part before `dmesg -c` is useful for
> 
> Sorry I did not consider about the line length when replying your V1.
> Although I'm not sure if kexec-tools strictly use 80 lines coding style

s/80 lines/80 columns

BTW, usually you should cc the person who commented about your patch.
There's a kernel doc in kernel tree Documentation/SubmittingPatches
Though it is only for kernel but some of the rules is generic.

Thanks
Dave

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
