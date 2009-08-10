Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mercury.realtime.net ([205.238.132.86])
	by bombadil.infradead.org with esmtp (Exim 4.69 #1 (Red Hat Linux))
	id 1MaPbl-0003px-U5
	for kexec@lists.infradead.org; Mon, 10 Aug 2009 07:47:58 +0000
From: Milton Miller <miltonm@bga.com>
Subject: Re: [PATCH] Do not inline putprops function
In-Reply-To: <20090805164938.GA2970@in.ibm.com>
Date: Mon, 10 Aug 2009 02:37:49 -0500
Message-ID: <1249889869_10618@mercury.realtime.net>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=subscribe>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: "M. Mohan Kumar" <mohan@in.ibm.com>
Cc: Michael Ellerman <michael@ellerman.id.au>, kexec@lists.infradead.org, Simon Horman <horms@verge.net.au>, linuxppc-dev@lists.ozlabs.org

On Thu Aug 6 at about 02:49:38 EST in 2009, M. Mohan Kumar  wrote:
>
> When I align the dtstruct variable to 8 bytes, I am able to invoke kdump.
> 
> When the line
> 	static unsigned dtstruct[TREEWORDS], *dt;
> changed to 
> 	static unsigned dtstruct[TREEWORDS] __attribute__ ((aligned (8))), *dt;
> 
> kexec-tool works.


Doh.  that is the correct fix.

kexec is creating a version 3 device tree, to be backwards compatible
as far as possible.  (Well, that and it was written before version 3
existed).  This version of the struct has 8-byte alignment for properties
whose value is 8 or more bytes.  As the code directly checks the pointer
when deciding to add the alignment word, the struct memory must start on
an 8 byte boundary.

Mohan, please prepare a patch with the above text in the changelog 
and send it to Simon.

thanks.
milton

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
