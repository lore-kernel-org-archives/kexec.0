Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from out03.mta.xmission.com ([166.70.13.233])
 by bombadil.infradead.org with esmtps (Exim 4.85_2 #1 (Red Hat Linux))
 id 1bxSOk-0008DA-TF
 for kexec@lists.infradead.org; Fri, 21 Oct 2016 05:29:43 +0000
From: ebiederm@xmission.com (Eric W. Biederman)
References: <1477012516-20470-1-git-send-email-f.fainelli@gmail.com>
 <20161020.215410.650162338407203719.davem@davemloft.net>
Date: Fri, 21 Oct 2016 00:26:55 -0500
In-Reply-To: <20161020.215410.650162338407203719.davem@davemloft.net> (David
 Miller's message of "Thu, 20 Oct 2016 21:54:10 -0400 (EDT)")
Message-ID: <871szagtls.fsf@xmission.com>
MIME-Version: 1.0
Subject: Re: [PATCH] kexec: Export kexec_in_progress to modules
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
To: David Miller <davem@davemloft.net>
Cc: netdev@vger.kernel.org, f.fainelli@gmail.com, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, sfr@canb.auug.org.au

David Miller <davem@davemloft.net> writes:

> From: Florian Fainelli <f.fainelli@gmail.com>
> Date: Thu, 20 Oct 2016 18:15:16 -0700
>
>> The bcm_sf2 driver uses kexec_in_progress to know whether it can power
>> down an integrated PHY during shutdown, and can be built as a module.
>> Other modules may be using this in the future, so export it.
>> 
>> Fixes: 2399d6143f85 ("net: dsa: bcm_sf2: Prevent GPHY shutdown for kexec'd kernels")
>> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
>> ---
>> Eric, David, Stephen,
>> 
>> The offending commit is in David's net.git tree, so it would probably make
>> sense to route the fix through the same tree.
>
> Ok, I'll apply this, thanks Florian.

Florian

I am completely confused why any driver would want to do this.

A reboot is semantically identical to a kexec restart.  Always has been.
That is pwoering down your hardware during reboot is not safe.

The only thing that might save you is the hardware reset line being
toggled at which point your hardware is powered up again anyway.

So as far as I can tell you are advocating for a change to support a
driver doing something that is completely pointless.  So no let's not
export this symbol.  Please fix the driver to do something less
pointless instead.

Eric



_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
