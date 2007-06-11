Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from e1.ny.us.ibm.com ([32.97.182.141])
	by canuck.infradead.org with esmtps (Exim 4.63 #1 (Red Hat Linux))
	id 1Hxh1Y-00032Y-Li
	for kexec@lists.infradead.org; Mon, 11 Jun 2007 06:21:28 -0400
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
	by e1.ny.us.ibm.com (8.13.8/8.13.8) with ESMTP id l5BALAGo016522
	for <kexec@lists.infradead.org>; Mon, 11 Jun 2007 06:21:10 -0400
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
	by d01relay02.pok.ibm.com (8.13.8/8.13.8/NCO v8.3) with ESMTP id
	l5BALA4q469698
	for <kexec@lists.infradead.org>; Mon, 11 Jun 2007 06:21:10 -0400
Received: from d01av02.pok.ibm.com (loopback [127.0.0.1])
	by d01av02.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l5BALAfu007260
	for <kexec@lists.infradead.org>; Mon, 11 Jun 2007 06:21:10 -0400
Date: Mon, 11 Jun 2007 15:50:52 +0530
From: Vivek Goyal <vgoyal@in.ibm.com>
Subject: Re: [Fastboot] 64 bit to 32 bit kernel through kexec?
Message-ID: <20070611102052.GD20057@in.ibm.com>
References: <FD98A53269F5F74082DFBB12E8AA603208D1E226@TRM-EXCH1.CORP.NASDAQ.COM>
Mime-Version: 1.0
Content-Disposition: inline
In-Reply-To: <FD98A53269F5F74082DFBB12E8AA603208D1E226@TRM-EXCH1.CORP.NASDAQ.COM>
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
To: "Leong, Gary" <Gary.Leong@nasdaq.com>
Cc: Kexec Mailing List <kexec@lists.infradead.org>

On Tue, Jun 05, 2007 at 02:26:46PM -0400, Leong, Gary wrote:
> I had a quick question, I'm using kexec to boot from a 32 bit to 64 bit
> kernel.  I'm having no problems at this point, but wasn't sure if I will
> have problems.  
> 
>  
> 
> Do you know of any theoretical issues going from 64 bit to 32 bit and
> vice versa?  I figure the former should pose the least amount of
> problems.  
> 
>  
> 
> Anyhow, any help would appreciate.  Thanks in advance!

Gary,

The mailing list for kexec discussions has changed. So copying it to
differnt list. 

AFAIK, on x86_64, 64bit to 32bit kexec or vice versa works just fine and
it is not by chance. It has been designed that way.

Thanks
Vivek

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
