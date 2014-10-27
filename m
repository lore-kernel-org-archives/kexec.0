Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1Xiopb-000503-GG
 for kexec@lists.infradead.org; Mon, 27 Oct 2014 18:15:52 +0000
Message-ID: <544E8BB8.8000707@redhat.com>
Date: Mon, 27 Oct 2014 14:15:20 -0400
From: Prarit Bhargava <prarit@redhat.com>
MIME-Version: 1.0
Subject: Re: [PATCH V4] kernel, add bug_on_warn
References: <1414155207-29839-1-git-send-email-prarit@redhat.com>
 <544E8985.50203@akamai.com>
In-Reply-To: <544E8985.50203@akamai.com>
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
To: Jason Baron <jbaron@akamai.com>
Cc: Andi Kleen <ak@linux.intel.com>, Jonathan Corbet <corbet@lwn.net>, kexec@lists.infradead.org, Rusty Russell <rusty@rustcorp.com.au>, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, Fabian Frederick <fabf@skynet.be>, isimatu.yasuaki@jp.fujitsu.com, "H. Peter Anvin" <hpa@zytor.com>, Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com>, Andrew Morton <akpm@linux-foundation.org>, linux-api@vger.kernel.org, vgoyal@redhat.com



On 10/27/2014 02:05 PM, Jason Baron wrote:
> Hi Prarit,
> 
> On 10/24/2014 08:53 AM, Prarit Bhargava wrote:
>> There have been several times where I have had to rebuild a kernel to
>> cause a panic when hitting a WARN() in the code in order to get a crash
>> dump from a system.  Sometimes this is easy to do, other times (such as
>> in the case of a remote admin) it is not trivial to send new images to the
>> user.panic_on_stackoverflow
>>
>> A much easier method would be a switch to change the WARN() over to a
>> BUG().  This makes debugging easier in that I can now test the actual
>> image the WARN() was seen on and I do not have to engage in remote
>> debugging.
>>
>> This patch adds a bug_on_warn kernel parameter and
>> /proc/sys/kernel/bug_on_warn calls BUG() in the warn_slowpath_common()
>> path.  The function will still print out the location of the warning.
>>
>> An example of the bug_on_warn output:
>>
>> The first line below is from the WARN_ON() to output the WARN_ON()'s location.
>> After that the new BUG() call is displayed.
>>
>>  WARNING: CPU: 27 PID: 3204 at
>> /home/rhel7/redhat/debug/dummy-module/dummy-module.c:25 init_dummy+0x28/0x30
>> [dummy_module]()
>>  bug_on_warn set, calling BUG()...
>>  ------------[ cut here ]------------
>>  kernel BUG at kernel/panic.c:434!
> 
> Seems reasonable-I'm wondering why you just don't call panic() in this
> case. The BUG() call at line '434' doesn't at anything since its just being
> called from panic.c.

Hmm ... I didn't even think about that.

> 
> So something like 'panic_on_warn' would seem to be more appropriate
> in keeping with things like 'panic_on_oops' or 'panic_on_stackoverflow'.

I like it a lot better that way too :)  I'm changing it to panic_on_warn unless
anyone has any strenuous objections.

P.

> 
> Thanks,
> 
> -Jason
> 

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
