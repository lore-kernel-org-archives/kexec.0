Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from rcdn-iport-5.cisco.com ([173.37.86.76])
 by bombadil.infradead.org with esmtps (Exim 4.85_2 #1 (Red Hat Linux))
 id 1bPx1V-0004PO-9G
 for kexec@lists.infradead.org; Wed, 20 Jul 2016 19:19:13 +0000
Subject: Re: IO memory read from /proc/vmcore leads to hang.
References: <57841399.1030703@cisco.com>
From: Daniel Walker <danielwa@cisco.com>
Message-ID: <578FCE9A.50305@cisco.com>
Date: Wed, 20 Jul 2016 12:18:50 -0700
MIME-Version: 1.0
In-Reply-To: <57841399.1030703@cisco.com>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: kexec@lists.infradead.org, "xe-kernel@external.cisco.com" <xe-kernel@external.cisco.com>, mahesh@linux.vnet.ibm.com


Mahesh, I didn't get your email for some reason . I saw it in the Archives.

makedumpfile doesn't appear to have a way to drop free form memory 
areas. So I need to drop 00800000 to 00807fff , but I don't see a way to 
do that. Any other suggestions on how to prevent this hang ?



On 07/11/2016 02:46 PM, Daniel Walker wrote:
>
> Hi,
>
> I found found that on my Powerpc machine there is some IO memory which 
> will cause the box to hang if I read it. It's a custom device that was 
> added to the board for a special purpose.
>
> I was looking for a way to exclude this memory from the dump, and 
> while doing that I found that kexec makes a list of memory segments 
> that go into the core file. I was wondering why most of the kexec 
> architecture don't appear to exclude device memory like what's listed 
> in /proc/iomem.
>
> Is there a good reason why that's not the case?
>
> Daniel


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
