From: Joerg Roedel <jroedel@suse.de>
Date: Wed, 26 Jan 2022 10:27:23 +0100
Subject: [PATCH v2 03/12] x86/sev: Save and print negotiated GHCB
 protocol version
In-Reply-To: <YYKcS2OIzAV+MTzr@zn.tnic>
References: <20210913155603.28383-1-joro@8bytes.org>
 <20210913155603.28383-4-joro@8bytes.org> <YYKcS2OIzAV+MTzr@zn.tnic>
Message-ID: <YfET+7amPSKLnZWu@suse.de>
List-Id: <kexec.lists.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: kexec@lists.infradead.org

On Wed, Nov 03, 2021 at 03:27:23PM +0100, Borislav Petkov wrote:
> On Mon, Sep 13, 2021 at 05:55:54PM +0200, Joerg Roedel wrote:
> > From: Joerg Roedel <jroedel@suse.de>
> > 
> > Save the results of the GHCB protocol negotiation into a data structure
> > and print information about versions supported and used to the kernel
> > log.
> 
> Which is useful for?

For easier debugging, I added a sentence about that to the changelog.

> > +struct sev_ghcb_protocol_info {
> 
> Too long a name - ghcb_info is perfectly fine.

Changed, thanks.

-- 
J?rg R?del
jroedel at suse.de

SUSE Software Solutions Germany GmbH
Maxfeldstr. 5
90409 N?rnberg
Germany
 
(HRB 36809, AG N?rnberg)
Gesch?ftsf?hrer: Ivo Totev


