Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from terminus.zytor.com ([198.137.202.10] helo=mail.zytor.com)
	by canuck.infradead.org with esmtps (Exim 4.72 #1 (Red Hat Linux))
	id 1PXftf-0002oh-RF
	for kexec@lists.infradead.org; Tue, 28 Dec 2010 20:11:52 +0000
Message-ID: <4D1A4469.2060000@zytor.com>
Date: Tue, 28 Dec 2010 12:11:21 -0800
From: "H. Peter Anvin" <hpa@zytor.com>
MIME-Version: 1.0
Subject: Re: How does kdump deal with trampoline allocation?
References: <4D18F798.4010708@zytor.com>
	<20101228000651.GB4142@redhat.com>	<4D192BC3.8040802@zytor.com>
	<m1lj3auyzr.fsf@fess.ebiederm.org>
In-Reply-To: <m1lj3auyzr.fsf@fess.ebiederm.org>
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
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Yinghai Lu <yinghai@kernel.org>, "kexec@lists.infradead.org" <kexec@lists.infradead.org>, Vivek Goyal <vgoyal@redhat.com>

On 12/27/2010 11:40 PM, Eric W. Biederman wrote:
>>
>> OK, that's straightforward.  That presumably means that the low 640K is
>> marked unused in the memory map that memblock sees during early startup.
>>  That fits very cleanly with the patches I'm doing.
> 
> Additionally we typically start with maxcpus=1 so we don't strictly
> need the trampoline to start other cpus.
> 

Well, the trampoline is optional only on 32 bits, and with my changes,
it would be unconditional.

	-hpa

-- 
H. Peter Anvin, Intel Open Source Technology Center
I work for Intel.  I don't speak on their behalf.


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
