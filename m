Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from e32.co.us.ibm.com ([32.97.110.150])
	by canuck.infradead.org with esmtps (Exim 4.72 #1 (Red Hat Linux))
	id 1QAq8Y-0001l5-5O
	for kexec@lists.infradead.org; Fri, 15 Apr 2011 21:01:10 +0000
Received: from d03relay03.boulder.ibm.com (d03relay03.boulder.ibm.com
	[9.17.195.228])
	by e32.co.us.ibm.com (8.14.4/8.13.1) with ESMTP id p3FKo0c1008627
	for <kexec@lists.infradead.org>; Fri, 15 Apr 2011 14:50:00 -0600
Received: from d03av04.boulder.ibm.com (d03av04.boulder.ibm.com [9.17.195.170])
	by d03relay03.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	p3FL11qb103378
	for <kexec@lists.infradead.org>; Fri, 15 Apr 2011 15:01:01 -0600
Received: from d03av04.boulder.ibm.com (loopback [127.0.0.1])
	by d03av04.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP
	id p3FL1067029236
	for <kexec@lists.infradead.org>; Fri, 15 Apr 2011 15:01:00 -0600
Date: Fri, 15 Apr 2011 14:00:51 -0700
From: Nishanth Aravamudan <nacc@us.ibm.com>
Subject: Re: [PATCH] powerpc: Fix kexec-related UP build error
Message-ID: <20110415210051.GA31245@us.ibm.com>
References: <20110415202916.GA6758@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20110415202916.GA6758@linux.vnet.ibm.com>
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
To: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Cc: paulus@samba.org, linuxppc-dev@lists.ozlabs.org, ebiederm@xmission.com, kexec@lists.infradead.org, linux-kernel@vger.kernel.org

Hi Paul,

On 15.04.2011 [13:29:16 -0700], Paul E. McKenney wrote:
> Hello!
> 
> The following patch fixes a UP build problem for kexec() on powerpc.
> When the crash_kexec_wait_realmode() function was added, it was
> placed in only two of the three required locations.

I believe the fix has already been posted as

http://lists.ozlabs.org/pipermail/linuxppc-dev/2011-April/089559.html

Thanks,
Nish 

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
