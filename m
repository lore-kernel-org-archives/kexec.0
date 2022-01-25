From: Luis Chamberlain <mcgrof@kernel.org>
Date: Tue, 25 Jan 2022 12:27:13 -0800
Subject: [PATCH v5 6/6] module: Move duplicate mod_check_sig users code
 to mod_parse_sig
In-Reply-To: <687db74a714d50b9c83d7ac024da4f7dec0d9a1d.1641900831.git.msuchanek@suse.de>
References: <cover.1641900831.git.msuchanek@suse.de>
 <687db74a714d50b9c83d7ac024da4f7dec0d9a1d.1641900831.git.msuchanek@suse.de>
Message-ID: <YfBdIdVqOriKF+yA@bombadil.infradead.org>
List-Id: <kexec.lists.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: kexec@lists.infradead.org

On Tue, Jan 11, 2022 at 12:37:48PM +0100, Michal Suchanek wrote:
> Multiple users of mod_check_sig check for the marker, then call
> mod_check_sig, extract signature length, and remove the signature.
> 
> Put this code in one place together with mod_check_sig.
> 
> This changes the error from ENOENT to ENODATA for ima_read_modsig in the
> case the signature marker is missing.
> 
> This also changes the buffer length in ima_read_modsig from size_t to
> unsigned long. This reduces the possible value range on 32bit but the
> length refers to kernel in-memory buffer which cannot be longer than
> ULONG_MAX.
> 
> Also change mod_check_sig to unsigned long while at it.
> 
> Signed-off-by: Michal Suchanek <msuchanek@suse.de>

Reviewed-by: Luis Chamberlain <mcgrof@kernel.org>

  Luis

