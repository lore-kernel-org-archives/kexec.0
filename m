Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from e32.co.us.ibm.com ([32.97.110.150])
	by canuck.infradead.org with esmtps (Exim 4.72 #1 (Red Hat Linux))
	id 1QAqFb-0001no-FE
	for kexec@lists.infradead.org; Fri, 15 Apr 2011 21:08:27 +0000
Received: from d03relay01.boulder.ibm.com (d03relay01.boulder.ibm.com
	[9.17.195.226])
	by e32.co.us.ibm.com (8.14.4/8.13.1) with ESMTP id p3FKvJPE016379
	for <kexec@lists.infradead.org>; Fri, 15 Apr 2011 14:57:19 -0600
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
	by d03relay01.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	p3FL8KHV099332
	for <kexec@lists.infradead.org>; Fri, 15 Apr 2011 15:08:20 -0600
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
	by d03av01.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP
	id p3FL8KKO003135
	for <kexec@lists.infradead.org>; Fri, 15 Apr 2011 15:08:20 -0600
Date: Fri, 15 Apr 2011 14:08:19 -0700
From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: Re: [PATCH] powerpc: Fix kexec-related UP build error
Message-ID: <20110415210819.GE2283@linux.vnet.ibm.com>
References: <20110415202916.GA6758@linux.vnet.ibm.com>
	<20110415210051.GA31245@us.ibm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20110415210051.GA31245@us.ibm.com>
Reply-To: paulmck@linux.vnet.ibm.com
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
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: Nishanth Aravamudan <nacc@us.ibm.com>
Cc: paulus@samba.org, linuxppc-dev@lists.ozlabs.org, ebiederm@xmission.com, kexec@lists.infradead.org, linux-kernel@vger.kernel.org

On Fri, Apr 15, 2011 at 02:00:51PM -0700, Nishanth Aravamudan wrote:
> Hi Paul,
> 
> On 15.04.2011 [13:29:16 -0700], Paul E. McKenney wrote:
> > Hello!
> > 
> > The following patch fixes a UP build problem for kexec() on powerpc.
> > When the crash_kexec_wait_realmode() function was added, it was
> > placed in only two of the three required locations.
> 
> I believe the fix has already been posted as
> 
> http://lists.ozlabs.org/pipermail/linuxppc-dev/2011-April/089559.html

So it has!  Thank you for the pointer.

							Thanx, Paul

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
