From: Heiko Carstens <hca@linux.ibm.com>
Date: Mon, 10 Jan 2022 18:26:54 +0100
Subject: [PATCH 1/1] s390: handle R_390_PLT32DBL reloc entries in
 machine_apply_elf_rel()
In-Reply-To: <87mtk3lina.fsf@oc8242746057.ibm.com>
References: <20211208125355.256391-1-egorenar@linux.ibm.com>
 <20211213114430.77f28a67@rhtmp>
 <20211215124300.GA4314@vergenet.net> <YboqYTz8NziIYJwC@osiris>
 <87mtk3lina.fsf@oc8242746057.ibm.com>
Message-ID: <YdxsXlGW9QVeiMv1@osiris>
List-Id: <kexec.lists.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: kexec@lists.infradead.org

On Mon, Jan 10, 2022 at 04:23:05PM +0100, Alexander Egorenkov wrote:
> Heiko Carstens <hca@linux.ibm.com> writes:
> > Given that Alexander is currently not available, I will resend his
> > patch with an updated commit message.
> 
> Many thanks for the review and taking care of the review finding.

But it looks like this still hasn't been applied to the kexec-tools
git tree, unless I'm mistaken(?)

