Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail.kazeon.com ([209.172.74.40] helo=bigfoot.kazeon.com)
	by canuck.infradead.org with esmtp (Exim 4.63 #1 (Red Hat Linux))
	id 1HoNZe-0005He-1H
	for kexec@lists.infradead.org; Wed, 16 May 2007 13:46:44 -0400
Content-class: urn:content-classes:message
MIME-Version: 1.0
Subject: RE: kexec and kdb
Date: Wed, 16 May 2007 10:45:12 -0700
Message-ID: <4E022DDAB8F45741914ACD6EDFE2309B0426E191@BIGFOOT.kazeon.local>
In-Reply-To: <20070515075450.GD8544@in.ibm.com>
From: "Preetesh Parekh" <preetesh@kazeon.com>
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
To: vgoyal@in.ibm.com
Cc: kexec@lists.infradead.org

You are right. It's working now. Thanks.

Preetesh

-----Original Message-----
From: Vivek Goyal [mailto:vgoyal@in.ibm.com] 
Sent: Tuesday, May 15, 2007 12:55 AM
To: Preetesh Parekh
Cc: kexec@lists.infradead.org
Subject: Re: kexec and kdb

On Mon, May 14, 2007 at 04:20:29PM -0700, Preetesh Parekh wrote:
> Hi Vivek,
> 
> I did modify "arch/i386/kernel/traps.c" file at 2 places as per your
> suggestion but still problem is not solved. Please let us know.
> 

This should have worked. What method are you using to simulate a crash.
If you are using "echo c > /proc/sysrq-trigger" then you also need
to modify drivers/char/sysrq.c file.

Thanks
Vivek

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
