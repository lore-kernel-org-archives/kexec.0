Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Subject: Re: [PATCH] kexec: Increase the upper limit for RAM segments
References: <1477005268-26943-1-git-send-email-sgoel@codeaurora.org>
 <cad5f084-b914-f522-eb43-71ed8a45b2a0@infradead.org>
 <43d2add1-15f5-7e62-b8ce-9a8afeff71f3@codeaurora.org>
From: Geoff Levand <geoff@infradead.org>
Message-ID: <90cd409d-6f5e-7b3b-dad4-fd13d08fffd5@infradead.org>
Date: Tue, 1 Nov 2016 12:24:46 -0700
MIME-Version: 1.0
In-Reply-To: <43d2add1-15f5-7e62-b8ce-9a8afeff71f3@codeaurora.org>
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
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: "Goel, Sameer" <sgoel@codeaurora.org>
Cc: kexec@lists.infradead.org

Hi Sameer,

On 10/31/2016 12:11 PM, Goel, Sameer wrote:
> This change is needed in case when the System Ram listings are retrieved from /proc/iomem. On a newer UEFI based Qualcomm system, the number of regions listed were close to 34. So, the actual system ram region was not covered and the kexec tool failed to load the kernel image.
> 
> So, I have requested an increase in the number of memory regions.
> Thanks,
> Sameer
> 
> On 10/21/2016 11:05 AM, Geoff Levand wrote:
>> Hi Sameer.
>>
>> On 10/20/2016 04:14 PM, Sameer Goel wrote:
>>> Change the current hardcoded values to 64 from 16.
>>
>> Please add an explanation of why this change is needed.

Sorry I wasn't clear.  Please post a new patch, and
in the commit log include an explanation of why this
change is needed.

-Geoff

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
