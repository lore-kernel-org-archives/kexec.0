From: Luis Chamberlain <mcgrof@kernel.org>
Date: Tue, 25 Jan 2022 12:24:37 -0800
Subject: [PATCH v5 5/6] module: Use key_being_used_for for log messages
 in verify_appended_signature
In-Reply-To: <65d9913441b16e27b672cfabbab24fa5c12bee14.1641900831.git.msuchanek@suse.de>
References: <cover.1641900831.git.msuchanek@suse.de>
 <65d9913441b16e27b672cfabbab24fa5c12bee14.1641900831.git.msuchanek@suse.de>
Message-ID: <YfBchUvuFovYvzEZ@bombadil.infradead.org>
List-Id: <kexec.lists.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: kexec@lists.infradead.org

On Tue, Jan 11, 2022 at 12:37:47PM +0100, Michal Suchanek wrote:
> Add value for kexec appended signature and pass in key_being_used_for
> enum rather than a string to verify_appended_signature to produce log
> messages about the signature.
> 
> Signed-off-by: Michal Suchanek <msuchanek@suse.de>

Acked-by: Luis Chamberlain <mcgrof@kernel.org>

  Luis

