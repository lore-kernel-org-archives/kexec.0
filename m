Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from out03.mta.xmission.com ([166.70.13.233])
 by bombadil.infradead.org with esmtps (Exim 4.85_2 #1 (Red Hat Linux))
 id 1bxek9-0005PR-MU
 for kexec@lists.infradead.org; Fri, 21 Oct 2016 18:40:39 +0000
From: ebiederm@xmission.com (Eric W. Biederman)
References: <1477012516-20470-1-git-send-email-f.fainelli@gmail.com>
 <20161020.215410.650162338407203719.davem@davemloft.net>
 <871szagtls.fsf@xmission.com>
 <20161021.101343.1389577512803674816.davem@davemloft.net>
Date: Fri, 21 Oct 2016 13:37:26 -0500
In-Reply-To: <20161021.101343.1389577512803674816.davem@davemloft.net> (David
 Miller's message of "Fri, 21 Oct 2016 10:13:43 -0400 (EDT)")
Message-ID: <87wph1eeft.fsf@xmission.com>
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

> From: ebiederm@xmission.com (Eric W. Biederman)
> Date: Fri, 21 Oct 2016 00:26:55 -0500
>
>> So as far as I can tell you are advocating for a change to support a
>> driver doing something that is completely pointless.  So no let's not
>> export this symbol.  Please fix the driver to do something less
>> pointless instead.
>
> FLorian explained his reasoning for doing what he is doing in this
> specific driver and it made sense to me.

What doesn't make sense to me is not doing that for any other kind of
reboot.

Of the 3 uses of kexec_in_progres in the kernel (not counting this one)
I think there is only one of them that is really valid.   And that one
is only valid because it is the least horrible thing the pci layer can
do.  (AKA it is a hack even there).

It really is nonsense having methods do different things depending on
context and that is why kexec_in_progress is not exeported.

As far as I can tell the use of kexec_in_progress winds up being
a fragile hack that will just cause more problems later on.

Florian is there a good readon why you don't just do?

static void bcm_sf2_sw_shutdown(struct platform_device *pdev)
{
        struct bcm_sf2_priv *priv = platform_get_drvdata(pdev);

	/* For a kernel about to be kexec'd we want to keep the GPHY on for a
         * successful MDIO bus scan to occur. If we did turn off the GPHY
	 * before (e.g: port_disable), this will also power it back on.
	 */
	if (priv->hw_params.num_gphy == 1)
		bcm_sf2_gphy_enable_set(priv->dev->ds, true);
}

I certainly don't see anything in the changelog to explain why that
isn't done.

Eric


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
