Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-qy0-f177.google.com ([209.85.216.177])
	by canuck.infradead.org with esmtps (Exim 4.72 #1 (Red Hat Linux))
	id 1PS5bF-0000xA-Em
	for kexec@lists.infradead.org; Mon, 13 Dec 2010 10:25:46 +0000
Received: by qyk27 with SMTP id 27so6116980qyk.15
	for <kexec@lists.infradead.org>; Mon, 13 Dec 2010 02:25:43 -0800 (PST)
Date: Mon, 13 Dec 2010 18:25:29 +0800
From: =?utf-8?Q?Am=C3=A9rico?= Wang <xiyou.wangcong@gmail.com>
Subject: Re: kdump broken on 2.6.37-rc4
Message-ID: <20101213102529.GA10907@cr0.nay.redhat.com>
References: <20101203111623.GA2741@redhat.com>
	<AANLkTi=Xvbi5M_cNRL=wC+uwksG08SiCyWcqdmwB_5TU@mail.gmail.com>
	<20101203171147.GA2299@redhat.com>
	<20101203175401.GE28603@hmsreliant.think-freely.org>
	<20101207105053.GA2803@redhat.com> <4CFE89FE.1090901@kernel.org>
	<20101208141942.GA2335@redhat.com> <4D00823A.9050808@kernel.org>
	<20101209124117.GA6032@redhat.com> <4D01377B.5070809@kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <4D01377B.5070809@kernel.org>
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
To: Yinghai Lu <yinghai@kernel.org>
Cc: Neil Horman <nhorman@redhat.com>, Stanislaw Gruszka <sgruszka@redhat.com>, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, "H. Peter Anvin" <hpa@zytor.com>, Maxim Uvarov <muvarov@gmail.com>

On Thu, Dec 09, 2010 at 12:09:31PM -0800, Yinghai Lu wrote:
>On 12/09/2010 04:41 AM, Stanislaw Gruszka wrote:
>> On Wed, Dec 08, 2010 at 11:16:10PM -0800, Yinghai Lu wrote:
>>>>> please check debug patches, and boot first kernel and kexec second kernel with "ignore_loglevel debug earlyprintk...."
>>>>
>>>> Second kernel does not print anything, so maybe it not even start.
>>>> Dmesg from primary kernel attached.
>>>>
>>>> Stanislaw
>>>
>>>
>>> please try attached debug patch.
>> 
>> With debug patch kdump kernel boot. Dmesg's from kdump and 
>> primary kernel in attachment.
>> 
>
>thanks.
>
>please check if this one works. it only put crashkernel low.
>

Yinghai, is it possible to add the debug patch to upstream too? For debugging
future kdump issues like this.

Thanks.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
