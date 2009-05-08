Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from terminus.zytor.com ([198.137.202.10])
	by bombadil.infradead.org with esmtps (Exim 4.69 #1 (Red Hat Linux))
	id 1M2XOL-0005Gw-CH
	for kexec@lists.infradead.org; Fri, 08 May 2009 21:14:08 +0000
Message-ID: <4A049F80.2090400@zytor.com>
Date: Fri, 08 May 2009 14:09:20 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
MIME-Version: 1.0
Subject: Re: [PATCH 09/14] x86, boot: add new runtime_address and runtime_size
	bzImage fields
References: <1241735222-6640-1-git-send-email-hpa@linux.intel.com>
	<1241735222-6640-10-git-send-email-hpa@linux.intel.com>
	<20090508075516.GF12808@uranus.ravnborg.org>
In-Reply-To: <20090508075516.GF12808@uranus.ravnborg.org>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Sam Ravnborg <sam@ravnborg.org>
Cc: Jeremy Fitzhardinge <jeremy@goop.org>, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, hbabu@us.ibm.com, ebiederm@xmission.com, ying.huang@intel.com, mingo@elte.hu, "H. Peter Anvin" <hpa@linux.intel.com>, tglx@linutronix.de, vgoyal@redhat.com

Sam Ravnborg wrote:
>>  	@:
>> @@ -50,6 +53,9 @@ suffix_$(CONFIG_KERNEL_GZIP)  = gz
>>  suffix_$(CONFIG_KERNEL_BZIP2) = bz2
>>  suffix_$(CONFIG_KERNEL_LZMA)  = lzma
> 
> No need for a recursive assignment here. Use ":="
> Ann we usually uses "-y" not "_y".
> 

Wasn't part of the patch, but OK :)

	-hpa

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
