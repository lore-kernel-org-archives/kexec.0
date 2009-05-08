Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from terminus.zytor.com ([198.137.202.10])
	by bombadil.infradead.org with esmtps (Exim 4.69 #1 (Red Hat Linux))
	id 1M2TOi-0003k5-It
	for kexec@lists.infradead.org; Fri, 08 May 2009 16:58:15 +0000
Message-ID: <4A0463D1.9090800@zytor.com>
Date: Fri, 08 May 2009 09:54:41 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
MIME-Version: 1.0
Subject: Re: [PATCH 01/14] x86,
	boot: align the .bss section in the decompressor
References: <1241735222-6640-1-git-send-email-hpa@linux.intel.com>
	<1241735222-6640-2-git-send-email-hpa@linux.intel.com>
	<20090508071759.GA12808@uranus.ravnborg.org>
In-Reply-To: <20090508071759.GA12808@uranus.ravnborg.org>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Sam Ravnborg <sam@ravnborg.org>
Cc: kexec@lists.infradead.org, linux-kernel@vger.kernel.org, hbabu@us.ibm.com, ebiederm@xmission.com, ying.huang@intel.com, mingo@elte.hu, "H. Peter Anvin" <hpa@linux.intel.com>, tglx@linutronix.de, vgoyal@redhat.com

Sam Ravnborg wrote:
>>  	}
>> +	. = ALIGN(32);
> 
> Where does this magic 32 comes from?
> I would assume the better choice would be:
> 	. = ALIGN(L1_CACHE_BYTES);
> 
> So we match the relevant CPU.
> 
> In general for alignmnet of output sections I see the need for:
> 1) Function call
> 2) L1_CACHE_BYTES
> 3) PAGE_SIZE
> 4) 2*PAGE_SIZE
> 
> But I see magic constant used here and there that does not match
> the above (when looking at all archs).
> So I act when I see a new 'magic' number..
> 

I picked 32 as being larger than the maximum known size that affects rep
performance, but L1_CACHE_BYTES really would make more sense, you're right.

	-hpa

-- 
H. Peter Anvin, Intel Open Source Technology Center
I work for Intel.  I don't speak on their behalf.


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
