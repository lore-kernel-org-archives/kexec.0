Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from terminus.zytor.com ([2001:1868:205::10] helo=mail.zytor.com)
	by canuck.infradead.org with esmtps (Exim 4.72 #1 (Red Hat Linux))
	id 1Pts5S-0005Xa-5g
	for kexec@lists.infradead.org; Mon, 28 Feb 2011 01:39:46 +0000
Message-ID: <4D6AFCCC.7050705@zytor.com>
Date: Sun, 27 Feb 2011 17:39:24 -0800
From: "H. Peter Anvin" <hpa@zytor.com>
MIME-Version: 1.0
Subject: Re: Saveoops: Making Kexec purgatory position-independent?
References: <20110226162008.GA23879@laptop> <4D6972CE.8040401@zytor.com>
	<m14o7q5m6d.fsf@fess.ebiederm.org>
In-Reply-To: <m14o7q5m6d.fsf@fess.ebiederm.org>
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
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: X86-ML <x86@kernel.org>, KEXEC-ML <kexec@lists.infradead.org>, "Ahmed S. Darwish" <darwish.07@gmail.com>, Haren Myneni <hbabu@us.ibm.com>, Simon Horman <horms@verge.net.au>, Ingo Molnar <mingo@elte.hu>, Vivek Goyal <vgoyal@redhat.com>

On 02/26/2011 04:57 PM, Eric W. Biederman wrote:
> 
> This isn't a case of the code not being position independent.  This is
> case of where the relocations are applied.
> 

This is a generic comment and may not apply to this particular case, but
it's pretty easy on x86 to build a chunk of code which is
self-relocating, meaning that it can be jumped to at any address without
any pre-relocation and do the necessary relocations itself.

	-hpa

-- 
H. Peter Anvin, Intel Open Source Technology Center
I work for Intel.  I don't speak on their behalf.


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
