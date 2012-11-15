Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from e9.ny.us.ibm.com ([32.97.182.139])
 by merlin.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1TYyye-0005Tw-EZ
 for kexec@lists.infradead.org; Thu, 15 Nov 2012 12:55:29 +0000
Received: from /spool/local
 by e9.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <kexec@lists.infradead.org> from <aravinda@linux.vnet.ibm.com>;
 Thu, 15 Nov 2012 07:55:27 -0500
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
 by d01dlp02.pok.ibm.com (Postfix) with ESMTP id 2AEA76E8043
 for <kexec@lists.infradead.org>; Thu, 15 Nov 2012 07:55:25 -0500 (EST)
Received: from d01av03.pok.ibm.com (d01av03.pok.ibm.com [9.56.224.217])
 by d01relay04.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 qAFCtPUj288484
 for <kexec@lists.infradead.org>; Thu, 15 Nov 2012 07:55:25 -0500
Received: from d01av03.pok.ibm.com (loopback [127.0.0.1])
 by d01av03.pok.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 qAFCtOn3019279
 for <kexec@lists.infradead.org>; Thu, 15 Nov 2012 10:55:25 -0200
Message-ID: <50A4E637.5010602@linux.vnet.ibm.com>
Date: Thu, 15 Nov 2012 18:25:19 +0530
From: Aravinda Prasad <aravinda@linux.vnet.ibm.com>
MIME-Version: 1.0
Subject: Re: [PATCH v2 0/7] makedumpfile security key filtering with eppic
References: <20121108133554.28410.99763.stgit@aravinda>
 <20121114145445.GC20215@redhat.com> <50A3CFAD.6090008@linux.vnet.ibm.com>
 <20121114201527.GM20215@redhat.com>
In-Reply-To: <20121114201527.GM20215@redhat.com>
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
Cc: ananth@in.ibm.com, mahesh@linux.vnet.ibm.com, kexec@lists.infradead.org, LChouinard@s2sys.com, tachibana@mxm.nes.nec.co.jp, kumagai-atsushi@mxc.nes.nec.co.jp, Dave Anderson <anderson@redhat.com>, buendgen@de.ibm.com



On 2012-11-15 01:45, Vivek Goyal wrote:

> On Wed, Nov 14, 2012 at 10:36:53PM +0530, Aravinda Prasad wrote:
> 
> [..]
>> The main intention is to remove confidential information from the dump
>> file, like ssh keys etc., which could be just few bytes, hence, may not
>> reduce the size of the dump significantly.
> 
> Where are these ssh keys? Are these in user space memory or kernel memory?
> How would one know the location of these keys?


Check out my previous mail which explains the keyring scenario in
detail. ssh key was a bad example.

> 
> Thanks
> Vivek
> 
> _______________________________________________
> kexec mailing list
> kexec@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/kexec
> 


-- 
Regards,
Aravinda


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
