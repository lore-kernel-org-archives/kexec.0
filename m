Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1XlHvd-0004v3-Ff
 for kexec@lists.infradead.org; Mon, 03 Nov 2014 13:44:18 +0000
Message-ID: <54578693.1050401@redhat.com>
Date: Mon, 03 Nov 2014 08:43:47 -0500
From: Prarit Bhargava <prarit@redhat.com>
MIME-Version: 1.0
Subject: Re: [PATCH V2] kernel, add bug_on_warn
References: <1413910077-9464-1-git-send-email-prarit@redhat.com>
 <87bnp491b3.fsf@rustcorp.com.au> <54478367.7030505@redhat.com>
 <87ppd984qv.fsf@rustcorp.com.au>
In-Reply-To: <87ppd984qv.fsf@rustcorp.com.au>
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
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: Andi Kleen <ak@linux.intel.com>, hedi@sgi.com, Jonathan Corbet <corbet@lwn.net>, linux-api@vger.kernel.org, linux-doc@vger.kernel.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, Fabian Frederick <fabf@skynet.be>, isimatu.yasuaki@jp.fujitsu.com, "H. Peter Anvin" <hpa@zytor.com>, Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com>, Andrew Morton <akpm@linux-foundation.org>, vgoyal@redhat.com



On 10/30/2014 08:25 PM, Rusty Russell wrote:
> Prarit Bhargava <prarit@redhat.com> writes:
>> On 10/22/2014 12:27 AM, Rusty Russell wrote:
>>> Prarit Bhargava <prarit@redhat.com> writes:
>>>> There have been several times where I have had to rebuild a kernel to
>>>> cause a panic when hitting a WARN() in the code in order to get a crash
>>>> dump from a system.  Sometimes this is easy to do, other times (such as
>>>> in the case of a remote admin) it is not trivial to send new images to the
>>>> user.
>>>
>>> What about during early boot?
>>
>> Hi Rusty,
>>
>> I really don't have a use case for this in early boot.  The kernel boots, the
>> initramfs, and then we run whatever init (systemd in my case).  A systemd script
>> configures kexec for kdump and that point kdump is "armed".  Doing a bug_on_warn
>> before this will simply result in a panicked system.  I don't get any "new"
>> information FWIW as I get a stack trace, etc., in both the WARN() and BUG() cases.
>>
>>>
>>> I'd recommend you use core_param().  Less code, and can be set on
>>> commandline.

Yeah, I was just starting to do this and then I saw Hedi's comment about
disabling panic_on_warn during kdump to avoid a situation where the kdump kernel
bogus panics on a warn.

So that makes the setup function look like:

static int __init panic_on_warn_setup(char *s)
{
        /* Enabling this on a kdump kernel could cause a bogus panic. */
        if (!is_kdump_kernel())
                panic_on_warn = 1;
        return 0;
}
early_param("panic_on_warn", panic_on_warn_setup);

... so I dunno if core_param would work here :(.  It would have been nice if it did.

P.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
