Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from terminus.zytor.com ([2001:1868:205::10] helo=mail.zytor.com)
 by casper.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1TQSTo-0006mh-C2
 for kexec@lists.infradead.org; Tue, 23 Oct 2012 00:36:25 +0000
Message-ID: <5085E663.6040307@zytor.com>
Date: Mon, 22 Oct 2012 17:35:47 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
MIME-Version: 1.0
Subject: Re: [PATCH v1 2/2] x86, apic: Disable BSP if boot cpu is AP
References: <20121016043357.20003.5885.stgit@localhost6.localdomain6>
 <20121016043528.20003.601.stgit@localhost6.localdomain6>
 <873916i88t.fsf@xmission.com> <5085A9A8.5020004@zytor.com>
 <87fw56fduo.fsf@xmission.com> <5085AD7D.106@zytor.com>
 <87a9vedyqe.fsf@xmission.com> <5085B0D0.9020508@zytor.com>
 <87mwze8abu.fsf@xmission.com>
In-Reply-To: <87mwze8abu.fsf@xmission.com>
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
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: len.brown@intel.com, fenghua.yu@intel.com, x86@kernel.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, rob.herring@calxeda.com, grant.likely@secretlab.ca, HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>, tglx@linutronix.de, mingo@elte.hu, vgoyal@redhat.com

On 10/22/2012 02:29 PM, Eric W. Biederman wrote:
>>
>> As I said, I thought Fenghua tried that but it didn't work, experimentally.
>
> Fair enough.  You described the problem with clearing bit 8 in a weird
> way.
>
> If the best we can muster are fuzzy memories it may be worth revisiting.
> Perhaps it works on enough cpu models to be interesting.
>

It isn't fuzzy memories... this was done as late as 1-2 months ago.  I 
just don't know the details.

Fenghua, could you help fill us in?

	-hpa


-- 
H. Peter Anvin, Intel Open Source Technology Center
I work for Intel.  I don't speak on their behalf.


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
