Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from e23smtp06.au.ibm.com ([202.81.31.148])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1aDtJa-0007xy-Fm
 for kexec@lists.infradead.org; Tue, 29 Dec 2015 12:23:47 +0000
Received: from localhost
 by e23smtp06.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <kexec@lists.infradead.org> from <zohar@linux.vnet.ibm.com>;
 Tue, 29 Dec 2015 22:23:23 +1000
Received: from d23relay10.au.ibm.com (d23relay10.au.ibm.com [9.190.26.77])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id A27DD3578047
 for <kexec@lists.infradead.org>; Tue, 29 Dec 2015 23:23:19 +1100 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay10.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 tBTCNBX161931658
 for <kexec@lists.infradead.org>; Tue, 29 Dec 2015 23:23:19 +1100
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 tBTCMkV5029219
 for <kexec@lists.infradead.org>; Tue, 29 Dec 2015 23:22:46 +1100
Message-ID: <1451391747.3078.44.camel@linux.vnet.ibm.com>
Subject: Re: [Linux-ima-devel] [PATCH v2 4/7] ima: measure and appraise
 kexec image and initramfs
From: Mimi Zohar <zohar@linux.vnet.ibm.com>
Date: Tue, 29 Dec 2015 07:22:27 -0500
In-Reply-To: <1451390772.3078.39.camel@linux.vnet.ibm.com>
References: <1450914903-5793-1-git-send-email-zohar@linux.vnet.ibm.com>
 <1450914903-5793-5-git-send-email-zohar@linux.vnet.ibm.com>
 <20151225053356.GA3398@dhcp-128-65.nay.redhat.com>
 <1451054749.3289.131.camel@linux.vnet.ibm.com>
 <20151228020829.GB2980@dhcp-128-65.nay.redhat.com>
 <1451307075.3289.224.camel@linux.vnet.ibm.com>
 <20151229082122.GA11810@dhcp-128-65.nay.redhat.com>
 <1451390772.3078.39.camel@linux.vnet.ibm.com>
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
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: Dave Young <dyoung@redhat.com>
Cc: "Luis R. Rodriguez" <mcgrof@suse.com>, kexec@lists.infradead.org, David Howells <dhowells@redhat.com>, linux-security-module@vger.kernel.org, linux-ima-devel@lists.sourceforge.net, David Woodhouse <dwmw2@infradead.org>, Vivek Goyal <vgoyal@redhat.com>

On Tue, 2015-12-29 at 07:06 -0500, Mimi Zohar wrote:
> On Tue, 2015-12-29 at 16:21 +0800, Dave Young wrote:

> This policy flexibility is needed at least until all files come from
> software providers with file signatures.  (RPM has been modified to
> include file signatures.)  Even then, in terms of kexec, some distros
> generate the initramfs on the target host and,  therefore, can not sign
> the initramfs.  The local user could, however, sign the initramfs on
> their own system.

Sorry, instead of "local user" the "local system/host owner" would be
more appropriate.

Mimi


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
