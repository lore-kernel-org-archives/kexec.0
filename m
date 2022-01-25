From: Luis Chamberlain <mcgrof@kernel.org>
Date: Tue, 25 Jan 2022 12:23:51 -0800
Subject: [PATCH v5 4/6] module: strip the signature marker in the
 verification function.
In-Reply-To: <96d29773b9ef418a71b1d8bbfd0a456a0f996ec6.1641900831.git.msuchanek@suse.de>
References: <cover.1641900831.git.msuchanek@suse.de>
 <96d29773b9ef418a71b1d8bbfd0a456a0f996ec6.1641900831.git.msuchanek@suse.de>
Message-ID: <YfBcVy62MidVTtux@bombadil.infradead.org>
List-Id: <kexec.lists.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: kexec@lists.infradead.org

On Tue, Jan 11, 2022 at 12:37:46PM +0100, Michal Suchanek wrote:
> It is stripped by each caller separately.
> 
> Note: this changes the error for kexec_file from EKEYREJECTED to ENODATA
> when the signature marker is missing.
> 
> Signed-off-by: Michal Suchanek <msuchanek@suse.de>
> ---
> v3: - Philipp Rudo <prudo@redhat.com>: Update the commit with note about
>       change of raturn value
>     - the module_signature.h is now no longer needed for kexec_file

Reviewed-by: Luis Chamberlain <mcgrof@kernel.org>

  Luis

