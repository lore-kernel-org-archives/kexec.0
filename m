Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from kirsty.vergenet.net ([202.4.237.240])
 by merlin.infradead.org with esmtp (Exim 4.76 #1 (Red Hat Linux))
 id 1SwRAf-00010M-MF
 for kexec@lists.infradead.org; Wed, 01 Aug 2012 05:08:34 +0000
Date: Wed, 1 Aug 2012 14:08:27 +0900
From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH] vmcore-dmesg: vmcore-dmesg: Make it work with new
 structured logging format
Message-ID: <20120801050827.GF19796@verge.net.au>
References: <20120730173248.GB2317@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20120730173248.GB2317@redhat.com>
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
To: Vivek Goyal <vgoyal@redhat.com>
Cc: Kexec Mailing List <kexec@lists.infradead.org>, "Eric W. Biederman" <ebiederm@xmission.com>

On Mon, Jul 30, 2012 at 01:32:48PM -0400, Vivek Goyal wrote:
> Now kernel has made kernel logging structured and exsisting vmcore-dmesg
> does not work with this new format. Hence kernel version 3.5 is broken. In
> 3.6 now a kernel patch has been put which exports relevant fields. This
> patch parses those fields and makes vmcore-dmesg work with new logging
> format.
> 
> Currently it does not display log levels or dictionary. I personally think
> that log levels are not very useful and it also requires additional kernel
> patches so that log levels are not bitfields and relevant information is
> exported to user space properly.
> 
> Concept of dictionary is new and relevant information is exported. One can
> possibly enahnce vmcore-dmesg to also print dictionary contents based on
> a user command line option.
> 
> Signed-off-by: Vivek Goyal <vgoyal@redhat.com>

Thanks, applied.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
