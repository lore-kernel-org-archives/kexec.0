Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from terminus.zytor.com ([2001:1868:205::10] helo=mail.zytor.com)
 by merlin.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1TcQIz-0001GY-QI
 for kexec@lists.infradead.org; Sun, 25 Nov 2012 00:42:42 +0000
Message-ID: <50B16975.7010402@zytor.com>
Date: Sat, 24 Nov 2012 16:42:29 -0800
From: "H. Peter Anvin" <hpa@zytor.com>
MIME-Version: 1.0
Subject: Re: [PATCH v4 6/6] kexec, x86_64: Load bzImage64 above 4G
References: <1353790066-20352-1-git-send-email-yinghai@kernel.org>
 <1353790066-20352-7-git-send-email-yinghai@kernel.org>
 <CAE9FiQXhz8cA7d0a8UA4YWBScrZnVnVAQTHqN3F0_f5omi1o1A@mail.gmail.com>
In-Reply-To: <CAE9FiQXhz8cA7d0a8UA4YWBScrZnVnVAQTHqN3F0_f5omi1o1A@mail.gmail.com>
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
To: Yinghai Lu <yinghai@kernel.org>
Cc: Haren Myneni <hbabu@us.ibm.com>, Simon Horman <horms@verge.net.au>, kexec@lists.infradead.org, "Eric W. Biederman" <ebiederm@xmission.com>, Vivek Goyal <vgoyal@redhat.com>

On 11/24/2012 04:38 PM, Yinghai Lu wrote:
> On Sat, Nov 24, 2012 at 12:47 PM, Yinghai Lu <yinghai@kernel.org> wrote:
>> need to check xloadflags to see the bzImage is for 64bit relocatable.
>>
>> -v2: add kexec-bzImage64.c according to Eric.
>> -v3: don't need to purgatory under 2g after Eric's change to purgatory code.
>> -v4: use locate_hole find position first then add_buffer... suggested by Eric
>>       add buffer for kernel image at last to make kexec-load faster.
>>       use xloadflags in setup_header to tell if is bzImage64.
>>       remove not cross GB boundary searching.
>>       add --entry-32bit and --real-mode for skipping bzImage64.
>
> -v5: attached. that is using USE_EXT_BOOT_PARAMS bit in xloadflags
>

Yinghai, revving the patch is pointless until we agree on the proper 
architectural direction.

	-hpa

-- 
H. Peter Anvin, Intel Open Source Technology Center
I work for Intel.  I don't speak on their behalf.


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
