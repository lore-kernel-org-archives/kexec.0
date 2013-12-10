Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from terminus.zytor.com ([2001:1868:205::10] helo=mail.zytor.com)
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1VqWtR-0001bb-Og
 for kexec@lists.infradead.org; Tue, 10 Dec 2013 23:39:12 +0000
Message-ID: <52A7A5D9.9030504@zytor.com>
Date: Tue, 10 Dec 2013 15:38:01 -0800
From: "H. Peter Anvin" <hpa@zytor.com>
MIME-Version: 1.0
Subject: Re: [PATCH v5 00/14] kexec kernel efi runtime support
References: <1386582147-9802-1-git-send-email-dyoung@redhat.com>
 <20131210152549.7975e3ac25d854e2ada63221@linux-foundation.org>
 <20131210233207.GI31437@pd.tnic>
In-Reply-To: <20131210233207.GI31437@pd.tnic>
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
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: Borislav Petkov <bp@alien8.de>, Andrew Morton <akpm@linux-foundation.org>
Cc: mjg59@srcf.ucam.org, linux-efi@vger.kernel.org, toshi.kani@hp.com, matt@console-pimps.org, greg@kroah.com, x86@kernel.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, James.Bottomley@HansenPartnership.com, horms@verge.net.au, ebiederm@xmission.com, Dave Young <dyoung@redhat.com>, vgoyal@redhat.com

On 12/10/2013 03:32 PM, Borislav Petkov wrote:
> On Tue, Dec 10, 2013 at 03:25:49PM -0800, Andrew Morton wrote:
>> On Mon,  9 Dec 2013 17:42:13 +0800 Dave Young <dyoung@redhat.com> wrote:
>>
>>> Here is the V5 patchset for supporting kexec kernel efi runtime.
>>
>> It's unclear (to me) who's supposed to merge this lot.  It's a "kexec"
>> patch which actually hits on efi and x86.
>>
>> I grabbed them for some -next testing but won't be offended if someone
>> else merges them ;)
> 
> I was under the impression that this should go through Matt's efi tree.
> Oh, and we need to finish reviewing them so picking them up now would be
> too premature, IMHO.
> 

My intent was to pick them into a separate branch of the tip tree either
directly or via Matt (since Matt feeds us anyway.)

But yes, work is still underway, although it is getting there.

	-hpa


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
