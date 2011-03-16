Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from e28smtp03.in.ibm.com ([122.248.162.3])
	by canuck.infradead.org with esmtps (Exim 4.72 #1 (Red Hat Linux))
	id 1PzjQa-0000Zc-Vn
	for kexec@lists.infradead.org; Wed, 16 Mar 2011 05:37:50 +0000
Received: from d28relay03.in.ibm.com (d28relay03.in.ibm.com [9.184.220.60])
	by e28smtp03.in.ibm.com (8.14.4/8.13.1) with ESMTP id p2G5bfnA026676
	for <kexec@lists.infradead.org>; Wed, 16 Mar 2011 11:07:41 +0530
Received: from d28av01.in.ibm.com (d28av01.in.ibm.com [9.184.220.63])
	by d28relay03.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	p2G5bfKR3637314
	for <kexec@lists.infradead.org>; Wed, 16 Mar 2011 11:07:41 +0530
Received: from d28av01.in.ibm.com (loopback [127.0.0.1])
	by d28av01.in.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
	p2G5bgJ5012494
	for <kexec@lists.infradead.org>; Wed, 16 Mar 2011 11:07:43 +0530
Date: Wed, 16 Mar 2011 11:07:40 +0530
From: Mahesh J Salgaonkar <mahesh@linux.vnet.ibm.com>
Subject: Re: [PATCH v1 0/6] makedumpfile: makedumpfile enhancement to
	filter out kernel data from vmcore
Message-ID: <20110316053740.GA6854@in.ibm.com>
References: <20110311075647.14587.50626.stgit@mars.in.ibm.com>
	<1823425025.382709.1299852470929.JavaMail.root@zmail05.collab.prod.int.phx2.redhat.com>
	<20110314114457.7e252f0d.oomichi@mxs.nes.nec.co.jp>
	<4D7EF934.3090008@linux.vnet.ibm.com>
	<20110315151247.23fc84bc.oomichi@mxs.nes.nec.co.jp>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20110315151247.23fc84bc.oomichi@mxs.nes.nec.co.jp>
Reply-To: mahesh@linux.vnet.ibm.com
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
To: Ken'ichi Ohmichi <oomichi@mxs.nes.nec.co.jp>
Cc: V Srivatsa <vsrivatsa@in.ibm.com>, Dave Anderson <anderson@redhat.com>, kexec@lists.infradead.org, Ananth N Mavinakayanahalli <ananth@in.ibm.com>, Reinhard <BUENDGEN@de.ibm.com>

Hi Ken'inchi,

On Tue, Mar 15, 2011 at 03:12:47PM +0900, Ken'ichi Ohmichi wrote:
> 
> Hi Mahesh,
> 
> In my idea, offset_eraseinfo points the *file offset* of the erased
> information and size_eraseinfo is the information size.
> 
> The erased information would contain *multiple* erased symbol names.
> For example, the following is based on your above example.
> 
>  	struct S1 {
>  		int a;
>  		int b;
>  		int c;
>  	};
>  	struct S2 {
>  		struct S1 *mystruct1;
>  		struct S1 *mystruct2;
>  	};
> 
>  	struct S2 mystruct2;
> 
>  	#Filter command
>  	erase mystruct2.mystruct1.a
>  	erase mystruct2.mystruct1.c
>  	erase mystruct2.mystruct2.b
> 
> 	#The erased information
>  	erase mystruct2.mystruct1.a 4
>  	erase mystruct2.mystruct1.c 4
>  	erase mystruct2.mystruct2.b 4
> 
> 
> The dumpfile image :
> 
>        header             dump data             the erased information
> +------------------+-----------------------+-------------------------------+
> | ................ | ..................... | erase mystruct2.mystruct1.a 4 |
> | offset_eraseinfo | ..................... | erase mystruct2.mystruct1.c 4 |
> |   size_eraseinfo | ..................... | erase mystruct2.mystruct2.b 4 |
> +------------------+-------------------------------------------------------+
>                                            : offset_eraseinfo (offset in dumpfile)
>                                             <------ size_eraseinfo ------->
>                                             

Will work on the cahnge.

Thanks,
-Mahesh.
> Thanks
> Ken'ichi Ohmichi

-- 
Signed-off-by: Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
