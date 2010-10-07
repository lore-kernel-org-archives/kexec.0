Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mga14.intel.com ([143.182.124.37])
	by canuck.infradead.org with esmtp (Exim 4.72 #1 (Red Hat Linux))
	id 1P3xKN-0005mo-71
	for kexec@lists.infradead.org; Thu, 07 Oct 2010 20:44:35 +0000
Message-ID: <4CAE3130.4010908@intel.com>
Date: Thu, 07 Oct 2010 13:44:32 -0700
From: "H. Peter Anvin" <h.peter.anvin@intel.com>
MIME-Version: 1.0
Subject: Re: [tip:core/memblock] x86, memblock: Fix crashkernel allocation
References: <4CABAF2A.5090501@kernel.org>
	<tip-9f4c13964b58608fbce05540743281ea3146c0e8@git.kernel.org>
	<20101006151449.GA7378@redhat.com> <4CACF531.2060407@intel.com>
	<20101006224704.GD7378@redhat.com> <4CAD01A9.9050907@intel.com>
	<20101007181804.GE23308@redhat.com>
	<4CAE1767.5040409@intel.com> <20101007192129.GC2581@redhat.com>
In-Reply-To: <20101007192129.GC2581@redhat.com>
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
Cc: "caiqian@redhat.com" <caiqian@redhat.com>, "linux-tip-commits@vger.kernel.org" <linux-tip-commits@vger.kernel.org>, Kexec Mailing List <kexec@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "mingo@redhat.com" <mingo@redhat.com>, "tglx@linutronix.de" <tglx@linutronix.de>, "yinghai@kernel.org" <yinghai@kernel.org>

On 10/07/2010 12:21 PM, Vivek Goyal wrote:
>>
>> It would be easy enough to either deprecate or make it an alias for
>> crashkernel=...<896M, which is basically what Yinghai's patch does.
> 
> Agreed.
> 
> So Yinghai's patch is fine. I need to write a patch for introducing
> crashkernel=X<Y syntax to make the behavior explicit. Will do...
> 

Sounds like a plan.  Thanks!

	-hpa

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
