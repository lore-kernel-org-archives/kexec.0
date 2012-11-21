Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from terminus.zytor.com ([2001:1868:205::10] helo=mail.zytor.com)
 by merlin.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1TbE2g-0002lS-V2
 for kexec@lists.infradead.org; Wed, 21 Nov 2012 17:24:55 +0000
Message-ID: <50AD0E58.4010000@zytor.com>
Date: Wed, 21 Nov 2012 09:24:40 -0800
From: "H. Peter Anvin" <hpa@zytor.com>
MIME-Version: 1.0
Subject: Re: [PATCH v3 4/4] kexec, x86_64: Load bzImage64 above 4G
References: <1353483098-14883-1-git-send-email-yinghai@kernel.org>
 <1353483098-14883-5-git-send-email-yinghai@kernel.org>
 <20121121143729.GC13114@redhat.com>
In-Reply-To: <20121121143729.GC13114@redhat.com>
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
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Vivek Goyal <vgoyal@redhat.com>
Cc: Haren Myneni <hbabu@us.ibm.com>, Simon Horman <horms@verge.net.au>, Yinghai Lu <yinghai@kernel.org>, "Eric W. Biederman" <ebiederm@xmission.com>, kexec@lists.infradead.org

On 11/21/2012 06:37 AM, Vivek Goyal wrote:
> On Tue, Nov 20, 2012 at 11:31:38PM -0800, Yinghai Lu wrote:
>
> [..]
>> +	/* avoid cross GB boundary */
>> +	align = real_mode->kernel_alignment;
>> +	addr = locate_hole(info, size, align, 0x100000, -1, -1);
>> +	if (addr == ULONG_MAX)
>> +		die("can not load bzImage64");
>> +	/* same GB ? */
>> +	while ((addr >> 30) != ((addr + size - 1) >> 30)) {
>> +		addr = locate_hole(info, size, align, 0x100000,
>> +				 round_down(addr + size - 1, (1UL<<30)), -1);
>> +		if (addr == ULONG_MAX)
>> +			die("can not load bzImage64");
>> +	}
>> +	dbgprintf("Found kernel buffer at %lx size %lx\n", addr, size);
>
> Where does this limitation of not loading kernel across GB boundary come
> from?
>

Seriously... that is bizarre.

	-hpa


-- 
H. Peter Anvin, Intel Open Source Technology Center
I work for Intel.  I don't speak on their behalf.


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
