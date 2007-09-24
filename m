Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from www17.your-server.de ([213.133.104.17])
	by canuck.infradead.org with esmtps (Exim 4.63 #1 (Red Hat Linux))
	id 1IZrs5-0000hT-IE
	for kexec@lists.infradead.org; Mon, 24 Sep 2007 13:37:27 -0400
Message-ID: <46F7F5C6.3030909@m3y3r.de>
Date: Mon, 24 Sep 2007 19:37:10 +0200
From: Thomas Meyer <thomas@m3y3r.de>
MIME-Version: 1.0
Subject: Re: [RFC][PATCH 1/2 -mm] kexec based hibernation -v3: kexec jump
References: <1190266447.21818.17.camel@caritas-dev.intel.com>	<20070920100941.GA12157@atrey.karlin.mff.cuni.cz>	<200709211024.35991.nigel@nigel.suspend2.net>
	<20070920180623.5d7da7b9.akpm@linux-foundation.org>
In-Reply-To: <20070920180623.5d7da7b9.akpm@linux-foundation.org>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org+dwmw2=infradead.org@lists.infradead.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Nigel Cunningham <nigel@nigel.suspend2.net>, nigel@suspend2.net, Kexec Mailing List <kexec@lists.infradead.org>, linux-kernel@vger.kernel.org, "Eric W. Biederman" <ebiederm@xmission.com>, Pavel Machek <pavel@ucw.cz>, "Huang, Ying" <ying.huang@intel.com>, linux-pm@lists.linux-foundation.org, Jeremy Maitin-Shepard <jbms@cmu.edu>

Andrew Morton schrieb:
> On Fri, 21 Sep 2007 10:24:34 +1000 Nigel Cunningham <nigel@nigel.suspend2.net> wrote:
>
>   
>> Hi Andrew.
>>
>> On Thursday 20 September 2007 20:09:41 Pavel Machek wrote:
>>     
>>> Seems like good enough for -mm to me.
>>>
>>> 									Pavel
>>>       
>> Andrew, if I recall correctly, you said a while ago that you didn't want 
>> another hibernation implementation in the vanilla kernel. If you're going to 
>> consider merging this kexec code, will you also please consider merging 
>> TuxOnIce?
>>
>>     
>
> The theory is that kexec-based hibernation will mainly use preexisting
> kexec code and will permit us to delete the existing hibernation
> implementation.
>
> That's different from replacing it
Before replacing existing hibernation implementations, someone should
fix kexec for i386 (maybe others?) EFI systems...



_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
