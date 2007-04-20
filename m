Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from e35.co.us.ibm.com ([32.97.110.153])
	by pentafluge.infradead.org with esmtps (Exim 4.63 #1 (Red Hat Linux))
	id 1Hen1X-0003Ti-OR
	for kexec@lists.infradead.org; Fri, 20 Apr 2007 07:55:16 +0100
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com
	[9.17.195.106])
	by e35.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id l3K6t3rq025655
	for <kexec@lists.infradead.org>; Fri, 20 Apr 2007 02:55:03 -0400
Received: from d03av04.boulder.ibm.com (d03av04.boulder.ibm.com [9.17.195.170])
	by d03relay04.boulder.ibm.com (8.13.8/8.13.8/NCO v8.3) with ESMTP id
	l3K6t3L2133020
	for <kexec@lists.infradead.org>; Fri, 20 Apr 2007 00:55:03 -0600
Received: from d03av04.boulder.ibm.com (loopback [127.0.0.1])
	by d03av04.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l3K6t2uu007114
	for <kexec@lists.infradead.org>; Fri, 20 Apr 2007 00:55:02 -0600
Date: Fri, 20 Apr 2007 12:24:51 +0530
From: Vivek Goyal <vgoyal@in.ibm.com>
Subject: Re: [Fastboot] kexec cant load OpenBSD
Message-ID: <20070420065451.GA14852@in.ibm.com>
References: <4627C7DA.7010401@esentire.com>
Mime-Version: 1.0
Content-Disposition: inline
In-Reply-To: <4627C7DA.7010401@esentire.com>
Reply-To: vgoyal@in.ibm.com
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
Errors-To: kexec-bounces+dwmw2=infradead.org+dwmw2=infradead.org@lists.infradead.org
To: Jon Steel <jon.steel@esentire.com>
Cc: fastboot@osdl.org, Kexec Mailing List <kexec@lists.infradead.org>, "Eric W. Biederman" <ebiederm@xmission.com>

On Thu, Apr 19, 2007 at 03:49:46PM -0400, Jon Steel wrote:
> Hi
> 
> Im running Gentoo and Im trying to use kexec to start up OpenBSD. I've
> got it set up correct because I can do a boot into Gentoo. Here is what
> happens:
> 
> base ~ # kexec -l /boot/bsd --type="elf-x86"
> Base address: d0200120 is not page aligned
> 

Above address indicates that some loadable program segment is not
page size(4K) aligned hence kexec is cribbing.

A, "readelf -l /boot/bsd" should display the various program headers.
I think you shall have to modify linker script of OpenBSD kernel to 
generate page size aligned loadable segments.

This does raise a question in my mind, why all the program headers
should be loaded at page size boundaries? Just because ease of handling
or there is some other reason too?

Eric, you want to shed some light on this requirement?

Thanks
Vivek

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
