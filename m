Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from kirsty.vergenet.net ([202.4.237.240])
 by merlin.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1UCglk-0004pA-2F
 for kexec@lists.infradead.org; Tue, 05 Mar 2013 01:34:16 +0000
Date: Tue, 5 Mar 2013 10:34:11 +0900
From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH v9 0/7] kexec: put bzImage and ramdisk above 4G for x86
 64bit
Message-ID: <20130305013410.GB16128@verge.net.au>
References: <1361506076-13112-1-git-send-email-yinghai@kernel.org>
 <512C7E02.8050602@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <512C7E02.8050602@redhat.com>
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
To: Dave Young <dyoung@redhat.com>
Cc: kexec@lists.infradead.org, Yinghai Lu <yinghai@kernel.org>, "Eric W. Biederman" <ebiederm@xmission.com>, Vivek Goyal <vgoyal@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>

On Tue, Feb 26, 2013 at 05:18:58PM +0800, Dave Young wrote:
> On 02/22/2013 12:07 PM, Yinghai Lu wrote:
> > Now we have limit kdump reserved under 896M, because kexec has the limitation.
> > and also bzImage need to stay under 4g.
> 
> I think the kernel patches has been merged in linus tree, I got a crash
> memory address above 4G during my test, kexec tools need this patchset
> to load the 2nd kernel..
> 
> BTW, Simon, do you have plan to release the 2.0.4?

Sorry, I have been slow.

I'll get onto applying these patches and releasing 2.0.4.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
