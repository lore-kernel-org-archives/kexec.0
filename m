Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from out02.mta.xmission.com ([166.70.13.232])
	by bombadil.infradead.org with esmtp (Exim 4.69 #1 (Red Hat Linux))
	id 1O5Beu-0002Pt-SR
	for kexec@lists.infradead.org; Fri, 23 Apr 2010 05:42:39 +0000
Subject: Re: [PATCH 0/5] Add second memory region for crash kernel
References: <1271953392-6324-1-git-send-email-v.mayatskih@gmail.com>
	<m1aasvkupc.fsf@fess.ebiederm.org> <20100422224525.GJ3228@redhat.com>
	<m1eii7j8ne.fsf@fess.ebiederm.org> <4BD12E48.3080400@redhat.com>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: Thu, 22 Apr 2010 22:42:25 -0700
In-Reply-To: <4BD12E48.3080400@redhat.com> (Cong Wang's message of "Fri\,
	23 Apr 2010 13\:21\:12 +0800")
Message-ID: <m1zl0uiv26.fsf@fess.ebiederm.org>
MIME-Version: 1.0
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
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Cong Wang <amwang@redhat.com>
Cc: Vitaly Mayatskikh <v.mayatskih@gmail.com>, Neil Horman <nhorman@tuxdriver.com>, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, Haren Myneni <hbabu@us.ibm.com>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>, Vivek Goyal <vgoyal@redhat.com>

Cong Wang <amwang@redhat.com> writes:

> Eric W. Biederman wrote:
>> Vivek Goyal <vgoyal@redhat.com> writes:
>>
>>> Vitaly, have you really run into cases where 2G upper limit is a concern.
>>> What is the configuration you have, how much memory it has and how much
>>> memory are you planning to reserve for kdump kernel?
>>
>> A good question.
>>
>
> We have observed that on a machine which has 66G memory, when we do
> crashkernel=1G@4G, kexec failed to load the crash kernel, but the memory
> reservation _did_ succeed.

Did you try loading vmlinux?   If not this sounds like the fact that
/sbin/kexec doesn't realize it can boot a 64bit bzImage in 64bit
mode.

Eric


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
