Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1YqDpY-0001yL-7I
 for kexec@lists.infradead.org; Thu, 07 May 2015 04:54:41 +0000
Message-ID: <554AEFF7.5070300@redhat.com>
Date: Thu, 07 May 2015 10:24:15 +0530
From: Pratyush Anand <panand@redhat.com>
MIME-Version: 1.0
Subject: Re: [PATCH RFC 0/3] arm64: disable/enable d-cache support for
References: <cover.1430742915.git.panand@redhat.com>
 <1430931959.12082.12.camel@infradead.org> <554A5151.7020706@redhat.com>
 <554AE924.4040208@linaro.org>
In-Reply-To: <554AE924.4040208@linaro.org>
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
To: AKASHI Takahiro <takahiro.akashi@linaro.org>, Geoff Levand <geoff@infradead.org>
Cc: kexec@lists.infradead.org



On Thursday 07 May 2015 09:55 AM, AKASHI Takahiro wrote:
> Geoff, Pratyush
>
> On 05/07/2015 02:37 AM, Pratyush Anand wrote:
>> Hi Geoff,
>>
>> On Wednesday 06 May 2015 10:35 PM, Geoff Levand wrote:
>>> Your 2 minutes seems like a long time.  Is this seen on other platforms?
>>
>> At least it is seen on two different HW platforms I had tested with. I
>> do not know about other.
>>
>> It would be nice if somebody else who is using kexec on HW platform
>> can report their execution time.
>
> On my HW, it took about 42secs before showing extra boot messages after
> "I'm in purgatory."
>

It would also depend on the size of different segments (mainly kernel 
and initrd) on which sha256 is calculated. What are the size of binaries 
in your case?

In my case:

segment[0].memsz = 0x10e0000 // kernel
segment[1].memsz = 0x1910000 // initrd
segment[2].memsz = 0x10000   // dtb
segment[3].memsz = 0x40000   // purgatory, not included in sha256
segment[4].memsz = 0x10000   // elf core hdr

@Geoff: Do you see any specific side effect for enabling D-cache in 
purgatory, other than the fact that it increases size of purgatory? May 
be we can keep an user option to select/not select d-cache enabling.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
