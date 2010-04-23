Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
	by bombadil.infradead.org with esmtp (Exim 4.69 #1 (Red Hat Linux))
	id 1O5BGg-0004MP-9q
	for kexec@lists.infradead.org; Fri, 23 Apr 2010 05:17:34 +0000
Message-ID: <4BD12E48.3080400@redhat.com>
Date: Fri, 23 Apr 2010 13:21:12 +0800
From: Cong Wang <amwang@redhat.com>
MIME-Version: 1.0
Subject: Re: [PATCH 0/5] Add second memory region for crash kernel
References: <1271953392-6324-1-git-send-email-v.mayatskih@gmail.com>	<m1aasvkupc.fsf@fess.ebiederm.org>
	<20100422224525.GJ3228@redhat.com>
	<m1eii7j8ne.fsf@fess.ebiederm.org>
In-Reply-To: <m1eii7j8ne.fsf@fess.ebiederm.org>
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
Cc: Vitaly Mayatskikh <v.mayatskih@gmail.com>, Neil Horman <nhorman@tuxdriver.com>, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, Haren Myneni <hbabu@us.ibm.com>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>, Vivek Goyal <vgoyal@redhat.com>

Eric W. Biederman wrote:
> Vivek Goyal <vgoyal@redhat.com> writes:
> 
>> Vitaly, have you really run into cases where 2G upper limit is a concern.
>> What is the configuration you have, how much memory it has and how much
>> memory are you planning to reserve for kdump kernel?
> 
> A good question.
> 

We have observed that on a machine which has 66G memory, when we do
crashkernel=1G@4G, kexec failed to load the crash kernel, but the memory
reservation _did_ succeed.

Thanks.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
