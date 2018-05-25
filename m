Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from out01.mta.xmission.com ([166.70.13.231])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1fMIkU-0005Nj-Qo
 for kexec@lists.infradead.org; Fri, 25 May 2018 19:51:40 +0000
From: ebiederm@xmission.com (Eric W. Biederman)
References: <1527160176-29269-1-git-send-email-zohar@linux.vnet.ibm.com>
 <1527160176-29269-2-git-send-email-zohar@linux.vnet.ibm.com>
 <87po1k2304.fsf@xmission.com>
 <alpine.LRH.2.21.1805260139030.11624@namei.org>
Date: Fri, 25 May 2018 14:51:00 -0500
In-Reply-To: <alpine.LRH.2.21.1805260139030.11624@namei.org> (James Morris's
 message of "Sat, 26 May 2018 01:41:52 +1000 (AEST)")
Message-ID: <871sdzy0nv.fsf@xmission.com>
MIME-Version: 1.0
Subject: Re: [PATCH v3 1/7] security: rename security_kernel_read_file() hook
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
To: James Morris <jmorris@namei.org>
Cc: Kees Cook <keescook@chromium.org>, Ard Biesheuvel <ard.biesheuvel@linaro.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, kexec@lists.infradead.org, linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org, David Howells <dhowells@redhat.com>, "Luis R . Rodriguez" <mcgrof@kernel.org>, Andres Rodriguez <andresx7@gmail.com>, Casey Schaufler <casey@schaufler-ca.com>, linux-integrity@vger.kernel.org, Mimi Zohar <zohar@linux.vnet.ibm.com>

James Morris <jmorris@namei.org> writes:

> On Thu, 24 May 2018, Eric W. Biederman wrote:
>
>> Below is where I suggest you start on sorting out these security hooks.
>> - Adding a security_kernel_arg to catch when you want to allow/deny the
>>   use of an argument to a syscall.  What security_kernel_file_read and
>>   security_kernel_file_post_read have been abused for.
>
> NAK. This abstraction is too semantically weak.
>
> LSM hooks need to map to stronger semantics so we can reason about what 
> the hook and the policy is supposed to be mediating.

I will take that as an extremely weak nack as all I did was expose the
existing code and what the code is currently doing.  I don't see how you
can NAK what is already being merged and used.

I will be happy to see a better proposal.

The best I can see is to take each and every syscall that my patch
is calling syscall_kernel_arg and make it it's own hook without an
enumeration.  I did not see any real duplication between the cases in my
enumeration so I don't think that will be a problem.  Maybe a bit of a
challenge for loadpin but otherwise not.

Thank you in this for understanding why I am having problems with the
current hook.

Eric


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
