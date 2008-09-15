Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from kirsty.vergenet.net ([202.4.237.240])
	by bombadil.infradead.org with esmtp (Exim 4.68 #1 (Red Hat Linux))
	id 1Kf87O-0001wm-TJ
	for kexec@lists.infradead.org; Mon, 15 Sep 2008 07:03:31 +0000
Date: Mon, 15 Sep 2008 17:03:29 +1000
From: Simon Horman <horms@verge.net.au>
Subject: Re: [patch kexec] Fix test for loaded kernel
Message-ID: <20080915070328.GC3160@verge.net.au>
References: <48CABE27.10301@am.sony.com> <48CAC406.4060608@am.sony.com>
	<48CDFE50.8080003@in.ibm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <48CDFE50.8080003@in.ibm.com>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Mohan Kumar M <mohan@in.ibm.com>
Cc: kexec@lists.infradead.org, Cell Broadband Engine OSS Development <cbe-oss-dev@ozlabs.org>, Geoff Levand <geoffrey.levand@am.sony.com>

On Mon, Sep 15, 2008 at 11:48:56AM +0530, Mohan Kumar M wrote:
> Hi Geoff,
>
>>
>> The only way to fix the NFS problem is to change the init scripts to
>> pass the -x option to kexec.
>
> Can we simply call ifup (that function does not exist now) to bring up  
> the network interface while returning from main() in kexec.c? This will  
> be executed only if kexec'ing a kernel fails.

Good greif, that ifdown() stuff seems horrible. I wonder what the
motivation for it is/was.

-- 
Simon Horman
  VA Linux Systems Japan K.K., Sydney, Australia Satellite Office
  H: www.vergenet.net/~horms/             W: www.valinux.co.jp/en


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
